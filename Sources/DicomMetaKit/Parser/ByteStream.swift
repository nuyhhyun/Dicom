//
//  ByteStream.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// Lightweight stream wrapper for safe byte access.
/// - Responsible for bounds checking and endianness conversion.
struct ByteStream {
    private let data: Data
    private(set) var offset: Int = 0

    init(_ data: Data) { self.data = data }

    /// Returns true if the stream has reached the end of data.
    var isAtEnd: Bool { offset >= data.count }

    /// Number of bytes remaining to be read.
    var remainingCount: Int { max(0, data.count - offset) }

    /// Advances the current offset by the given number of bytes.
    /// - Throws: `DicomError.truncatedData` if advancing goes out of bounds.
    mutating func advance(_ count: Int) throws {
        guard offset + count <= data.count else { throw DicomError.truncatedData }
        offset += count
    }
    
    /// Rewind the current offset by the given number of bytes.
    /// - Throws: `DicomError.truncatedData` if rewinding before the start.
    mutating func rewind(_ count: Int) throws {
        guard count <= offset else { throw DicomError.truncatedData }
        offset -= count
    }

    /// Reads the specified number of bytes and advances the offset.
    /// - Returns: A `Data` slice of the requested length.
    /// - Throws: `DicomError.truncatedData` if out of bounds.
    mutating func read(_ count: Int) throws -> Data {
        guard offset + count <= data.count else { throw DicomError.truncatedData }
        let slice = data.subdata(in: offset ..< offset + count)
        offset += count
        return slice
    }

    /// Returns a slice of the specified number of bytes without advancing the offset.
    mutating func peek(_ count: Int) throws -> Data {
        guard offset + count <= data.count else { throw DicomError.truncatedData }
        return data.subdata(in: offset ..< offset + count)
    }

    /// Reads a 16-bit unsigned integer from the stream with specified endianness.
    mutating func readUInt16(littleEndian: Bool) throws -> UInt16 {
        let raw = try read(2)
        return raw.withUnsafeBytes { ptr in
            let v = ptr.load(as: UInt16.self)
            return littleEndian ? UInt16(littleEndian: v) : UInt16(bigEndian: v)
        }
    }

    /// Reads a 32-bit unsigned integer from the stream with specified endianness.
    mutating func readUInt32(littleEndian: Bool) throws -> UInt32 {
        let raw = try read(4)
        return raw.withUnsafeBytes { ptr in
            let v = ptr.load(as: UInt32.self)
            return littleEndian ? UInt32(littleEndian: v) : UInt32(bigEndian: v)
        }
    }
}
