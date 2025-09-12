//
//  Tag.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// (group, element) 16-bit DICOM tag
public struct DicomTag: Hashable, Comparable, CustomStringConvertible, Sendable {
    public let group: UInt16
    public let element: UInt16

    public init(_ group: UInt16, _ element: UInt16) {
        self.group = group
        self.element = element
    }

    public static func < (lhs: DicomTag, rhs: DicomTag) -> Bool {
        lhs.group == rhs.group ? lhs.element < rhs.element : lhs.group < rhs.group
    }

    public var description: String {
        String(format: "(%04X,%04X)", group, element)
    }
}

/// Preset of tags oftenly used
public extension DicomTag {
    static let fileMetaInformationGroupLength = DicomTag(0x0002, 0x0000)
    static let transferSyntaxUID = DicomTag(0x0002, 0x0010)
    
    static let specificCharacterSet = DicomTag(0x0008, 0x0005)
    static let sopClassUID = DicomTag(0x0008, 0x0016)
    static let sopInstanceUID = DicomTag(0x0008, 0x0018)
    static let studyDate = DicomTag(0x0008, 0x0020)
    static let modality = DicomTag(0x0008, 0x0060)
    static let manufacturer = DicomTag(0x0008, 0x0070)
    
    static let patientName = DicomTag(0x0010, 0x0010)
    static let patientID = DicomTag(0x0010, 0x0020)
    static let patientBirthDate = DicomTag(0x0010, 0x0030)
    static let patientSex = DicomTag(0x0010, 0x0040)
    
    static let studyInstanceUID = DicomTag(0x0020, 0x000D)
    static let seriesInstanceUID = DicomTag(0x0020, 0x000E)
    
    static let pixelData = DicomTag(0x7FE0, 0x0010)
}
