//
//  Element.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// Represents a single DICOM element containing a tag, VR, and raw value.
public struct DicomElement {
    public let tag: DicomTag
    public let vr: DicomVR?          // Nil when VR is implicit
    public let value: Data

    public init(tag: DicomTag, vr: DicomVR?, value: Data) {
        self.tag = tag
        self.vr = vr
        self.value = value
    }

    /// Returns the value as a string if the VR is text-like.
    /// (MVP: Attempts ASCII decoding first, then UTF-8.)
    public var stringValue: String? {
        if let vr, !vr.isTextLike { return nil }
        return String(data: value, encoding: .ascii)
            ?? String(data: value, encoding: .utf8)
    }

    /// Returns a list of string components, split by backslash ('\'),
    /// for multi-valued text fields (VM > 1).
    public var stringComponents: [String]? {
        guard let s = stringValue else { return nil }
        return s.split(separator: "\\").map { String($0).trimmingCharacters(in: .whitespaces) }
    }

    /// Interprets the value as an array of Unsigned Shorts (US).
    /// Returns nil if length/alignment is invalid.
    public var uint16Array: [UInt16]? {
        guard value.count % 2 == 0 else { return nil }
        return value.withUnsafeBytes { ptr in
            Array(UnsafeBufferPointer(start: ptr.bindMemory(to: UInt16.self).baseAddress,
                                      count: value.count / 2))
        }
    }

    /// Interprets the value as an array of Unsigned Longs (UL).
    /// Returns nil if length/alignment is invalid.
    public var uint32Array: [UInt32]? {
        guard value.count % 4 == 0 else { return nil }
        return value.withUnsafeBytes { ptr in
            Array(UnsafeBufferPointer(start: ptr.bindMemory(to: UInt32.self).baseAddress,
                                      count: value.count / 4))
        }
    }
}
