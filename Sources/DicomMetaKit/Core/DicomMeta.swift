//
//  DicomMeta.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

public enum DicomMeta {
    /// Reads DICOM metadata from a file URL.
    /// - Parameters:
    ///   - url: Local file URL (.dcm)
    ///   - stopAtPixelData: If true, stops when encountering the Pixel Data tag.
    ///                      If false, continues parsing until the end (not recommended).
    public static func read(url: URL, stopAtPixelData: Bool = true) throws -> DicomDataset {
        let data = try Data(contentsOf: url)
        return try read(data: data, stopAtPixelData: stopAtPixelData)
    }
    
    /// Reads DICOM metadata from raw Data.
    /// - Parameters:
    ///   - data: Raw DICOM file bytes.
    ///   - stopAtPixelData: If true, stops when encountering the Pixel Data tag.
    ///                      If false, continues parsing until the end (not recommended).
    public static func read(data: Data, stopAtPixelData: Bool = true) throws -> DicomDataset {
        try DicomReader.parse(data: data,
                              stop: stopAtPixelData ? .stopAtPixelData : .parseAll)
    }
}
