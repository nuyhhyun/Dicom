//
//  Endian.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// VR interpretation mode
enum VRMode { case explicit, implicit }

/// Byte order (endianness)
struct Endian { let little: Bool }

/// Parsing stop policy
enum StopPolicy { case stopAtPixelData, parseAll }

/// Result of Transfer Syntax interpretation
enum TransferSyntax {
    case explicitLittle
    case explicitBig
    case implicitLittle
}

/// Maps a transfer syntax to its corresponding endianness and VR mode.
@inline(__always)
func tsToMode(_ ts: TransferSyntax) -> (Endian, VRMode) {
    switch ts {
    case .explicitLittle: return (Endian(little: true),  .explicit)
    case .explicitBig:    return (Endian(little: false), .explicit)
    case .implicitLittle: return (Endian(little: true),  .implicit)
    }
}

/// Map a Transfer Syntax UID to dataset encoding (ignoring pixel compression).
/// Most compressed-pixel syntaxes still use Explicit VR Little for the dataset.
@inline(__always)
func resolveDatasetEncoding(from tsUID: String?) throws -> TransferSyntax {
    guard let uid = tsUID, !uid.isEmpty else {
        // Fallback default (common in the wild)
        return .explicitLittle
    }

    switch uid {
    // --- Core syntaxes ---
    case "1.2.840.10008.1.2":           return .implicitLittle     // Implicit VR Little
    case "1.2.840.10008.1.2.1":         return .explicitLittle     // Explicit VR Little
    case "1.2.840.10008.1.2.2":         return .explicitBig        // Explicit VR Big (retired, but support)

    // --- Deflated dataset (whole dataset compressed) -> unsupported for MVP ---
    case "1.2.840.10008.1.2.1.99":
        throw DicomError.unsupportedTransferSyntax(uid)

    // --- Compressed pixel data (dataset is Explicit VR Little) ---
    // JPEG Baseline / Extended / Lossless / SV1
    case "1.2.840.10008.1.2.4.50",
         "1.2.840.10008.1.2.4.51",
         "1.2.840.10008.1.2.4.57",
         "1.2.840.10008.1.2.4.70":
        return .explicitLittle

    // JPEG-LS
    case "1.2.840.10008.1.2.4.80",
         "1.2.840.10008.1.2.4.81":
        return .explicitLittle

    // JPEG 2000 (lossless/lossy)
    case "1.2.840.10008.1.2.4.90",
         "1.2.840.10008.1.2.4.91",
         "1.2.840.10008.1.2.4.92",
         "1.2.840.10008.1.2.4.93":
        return .explicitLittle

    // RLE
    case "1.2.840.10008.1.2.5":
        return .explicitLittle

    default:
        // skips pixel data
        return .explicitLittle
    }
}
