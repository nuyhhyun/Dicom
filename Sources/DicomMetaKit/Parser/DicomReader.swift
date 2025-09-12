//
//  DicomReader.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// DICOM metadata parser (MVP).
/// - File Meta (0002,xxxx) is always encoded as Explicit VR Little Endian.
/// - Determines transfer syntax to decide endianness and VR mode for the dataset.
/// - Stops parsing at Pixel Data (7FE0,0010) by default.
enum DicomReader {

    static func parse(data: Data, stop: StopPolicy) throws -> DicomDataset {
        var s = ByteStream(data)

        // 128-byte preamble + "DICM"
        guard try s.read(128).count == 128,
              let magic = String(data: try s.read(4), encoding: .ascii),
              magic == "DICM"
        else { throw DicomError.invalidPreamble }

        // File Meta (0002,xxxx) — always Explicit VR Little Endian
        var elements: [DicomTag: DicomElement] = [:]
        try readElements(
            into: &elements,
            stream: &s,
            endian: Endian(little: true),
            vrMode: .explicit,
            untilGroupChangesFrom: 0x0002,
            stop: .parseAll // File Meta never contains Pixel Data
        )

        // Determine transfer syntax
        let tsUID = elements[.transferSyntaxUID]?.stringValue?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let ts: TransferSyntax = try resolveDatasetEncoding(from: tsUID)

        let (endian, vrMode) = tsToMode(ts)

        // Parse dataset metadata
        try readElements(
            into: &elements,
            stream: &s,
            endian: endian,
            vrMode: vrMode,
            untilGroupChangesFrom: nil,
            stop: stop
        )

        return DicomDataset(elements: elements)
    }

    /// Parses (Tag, VR, Length, Value) items sequentially from the stream and fills the dictionary with elements.
    private static func readElements(
        into dict: inout [DicomTag: DicomElement],
        stream s: inout ByteStream,
        endian: Endian,
        vrMode: VRMode,
        untilGroupChangesFrom fixedGroup: UInt16?, //stops when group changes from the specified value
        stop: StopPolicy
    ) throws {
        elementLoop: while !s.isAtEnd {
            // Read tag
            let group = try s.readUInt16(littleEndian: endian.little)
            let element = try s.readUInt16(littleEndian: endian.little)
            let tag = DicomTag(group, element)

            // Exit File Meta when group changes (0002 → another group)
            if let g = fixedGroup, group != g {
                // Rewind 4 bytes for the tag we just consumed (group + element)
                try s.rewind(4)
                break
            }

            // Stop at Pixel Data
            if stop == .stopAtPixelData, tag == .pixelData { break }

            let vr: DicomVR?
            let length: UInt32

            if vrMode == .explicit {
                // VR (2 bytes)
                let vrStr = String(data: try s.read(2), encoding: .ascii) ?? "UN"
                vr = DicomVR(rawValue: vrStr) ?? .UN

                if vr!.usesLongValueLengthField {
                    // 2-byte reserved + 4-byte length
                    _ = try s.read(2) // 0x0000
                    length = try s.readUInt32(littleEndian: endian.little)
                } else {
                    // 2-byte length
                    length = UInt32(try s.readUInt16(littleEndian: endian.little))
                }
            } else {
                // Implicit: no VR, length is 4 bytes
                vr = nil
                length = try s.readUInt32(littleEndian: endian.little)
            }

            // Undefined length (0xFFFFFFFF): mostly SQ or until end of stream.
//            if length == 0xFFFFFFFF {
//                try skipUndefinedLengthElement(stream: &s, endian: endian)
//                continue elementLoop
//            }
            if length == 0xFFFFFFFF {
                break
            }

            // Read value
//            guard length <= UInt32(s.remainingCount) else { throw DicomError.truncatedData }
            guard length <= UInt32(s.remainingCount) else {
                break
            }
            
            let value = try s.read(Int(length))

            dict[tag] = DicomElement(tag: tag, vr: vr, value: value)
        }
    }

    /// Skips an element with undefined length (0xFFFFFFFF).
    /// - Note: This is a simplified handler. It scans for sequence/item delimiters and stops at the first matching end marker.
    ///   Full SQ/Item parsing should be implemented in later stages.
    private static func skipUndefinedLengthElement(stream s: inout ByteStream, endian: Endian) throws {
        // DICOM Delimiters:
        // Item Start:   FFFE,E000 + length(4)
        // Item End:     FFFE,E00D + length(4) == 0
        // Sequence End: FFFE,E0DD + length(4) == 0
        // Strategy: Scan forward until E00D or E0DD delimiter is found.
        while !s.isAtEnd {
            // Ensure at least 8 bytes are available (group/element/length)
            if s.remainingCount < 8 { throw DicomError.truncatedData }
            let g = try s.readUInt16(littleEndian: endian.little)
            let e = try s.readUInt16(littleEndian: endian.little)
            let len = try s.readUInt32(littleEndian: endian.little)

            if g == 0xFFFE {
                if e == 0xE00D || e == 0xE0DD {
                    // Item End or Sequence End
                    if len > 0 {
                        try s.advance(Int(len))
                    }
                    return
                } else if e == 0xE000 {
                    // Item Start: skip its content
                    if len == 0xFFFFFFFF {
                        // Item with undefined length → recurse until delimiter
                        try skipUndefinedLengthElement(stream: &s, endian: endian)
                    } else {
                        try s.advance(Int(len))
                    }
                    continue
                }
            }

            // Other cases: advance len bytes (simplified fallback)
            if len <= UInt32(s.remainingCount) {
                try s.advance(Int(len))
            } else {
                throw DicomError.truncatedData
            }
        }
    }
}
