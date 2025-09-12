//
//  VR.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// DICOM Value Representation (complete set; extend helpers as needed)
public enum DicomVR: String {
    // Character / Text
    case AE, AS, CS, DA, DS, DT, IS, LO, LT, PN, SH, ST, TM, UC, UI, UR, UT

    // Binary / Numeric
    case AT, FD, FL, OB, OD, OF, OL, OV, OW, SL, SQ, SS, SV, UL, UN, US, UV
    // Notes:
    // - OL: Other Long (32-bit words)
    // - OV: Other Very Long (64-bit words)
    // - SV: Signed Very Long (64-bit)
    // - UV: Unsigned Very Long (64-bit)

    /// Whether this VR, in Explicit VR encoding, uses the "long value length field"
    /// i.e. 2 reserved bytes (0x0000) followed by a 4-byte length.
    var usesLongValueLengthField: Bool {
        switch self {
        case .OB, .OD, .OF, .OL, .OV, .OW, .SQ, .UC, .UR, .UT, .UN:
            return true
        default:
            return false
        }
    }

    /// Whether this VR represents text-like data (typically decodable via ASCII/UTF-8).
    var isTextLike: Bool {
        switch self {
        case .AE, .AS, .CS, .DA, .DS, .DT, .IS, .LO, .LT, .PN, .SH, .ST, .TM, .UC, .UI, .UR, .UT:
            return true
        default:
            return false
        }
    }

    /// VRs that commonly allow multiple values separated by a backslash ('\').
    /// (This is a heuristic; many VRs can be multi-valued per the standard's VM rules.)
    var isBackslashSeparated: Bool {
        switch self {
        case .AE, .CS, .DS, .IS, .LO, .PN, .SH, .UI:
            return true
        default:
            return false
        }
    }
}
