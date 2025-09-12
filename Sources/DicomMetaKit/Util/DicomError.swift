//
//  DicomError.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// Error definitions used across the library
public enum DicomError: Error, CustomStringConvertible, LocalizedError {
    /// 128-byte preamble + "DICM" marker is missing or invalid
    case invalidPreamble
    /// Encountered an unsupported Transfer Syntax UID
    case unsupportedTransferSyntax(String)
    /// File is truncated or ended unexpectedly
    case truncatedData
    /// Element is malformed (length/VR mismatch, etc.)
    case malformedElement(tag: DicomTag)

    // MARK: - CustomStringConvertible
    public var description: String {
        switch self {
        case .invalidPreamble:
            return "Invalid DICOM preamble or missing 'DICM' magic."
        case .unsupportedTransferSyntax(let ui):
            return "Unsupported Transfer Syntax UID: \(ui)"
        case .truncatedData:
            return "Unexpected end of data (truncated file)."
        case .malformedElement(let tag):
            return "Malformed element at tag \(tag)."
        }
    }

    // MARK: - LocalizedError
    public var errorDescription: String? {
        return description
    }

    public var failureReason: String? {
        switch self {
        case .invalidPreamble:
            return "The file does not contain a valid 128-byte preamble followed by the 'DICM' magic word."
        case .unsupportedTransferSyntax:
            return "The DICOM file uses a transfer syntax that is not supported by this library."
        case .truncatedData:
            return "The file ended unexpectedly, possibly due to corruption or incomplete download."
        case .malformedElement:
            return "An element's structure was inconsistent with its declared VR or length."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .invalidPreamble:
            return "Ensure the input file is a valid DICOM Part 10 compliant file."
        case .unsupportedTransferSyntax:
            return "Consider adding support for the required transfer syntax or converting the file using a DICOM toolkit."
        case .truncatedData:
            return "Try re-downloading or re-exporting the DICOM file."
        case .malformedElement:
            return "Verify the integrity of the DICOM file or try another viewer/tool."
        }
    }
}
