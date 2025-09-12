//
//  Dataset.swift
//  DicomMetaKit
//
//  Created by BoMin Lee on 9/11/25.
//

import Foundation

/// Container of parsed DICOM metadata elements.
public struct DicomDataset {
    public let elements: [DicomTag: DicomElement]

    public init(elements: [DicomTag: DicomElement]) {
        self.elements = elements
    }

    /// Access element directly by tag.
    public subscript(_ tag: DicomTag) -> DicomElement? {
        elements[tag]
    }

    /// Returns the string value for a given tag, if the VR is text-like.
    public func string(for tag: DicomTag) -> String? {
        elements[tag]?.stringValue
    }

    /// All tags in dictionary order (sorted).
    public var allTagsSorted: [DicomTag] {
        elements.keys.sorted()
    }

    /// Produces a readable dump of elements for debugging.
    public func prettyLines(maxValueLength: Int = 64) -> [String] {
        allTagsSorted.map { tag in
            let el = elements[tag]!
            let vr = el.vr?.rawValue ?? "??"
            let rawStr: String = {
                if let s = el.stringValue {
                    if s.count > maxValueLength {
                        let head = s.prefix(maxValueLength)
                        return "\"\(head)\"…(\(s.count) chars)"
                    }
                    return "\"\(s)\""
                } else {
                    return "\(el.value.count) bytes"
                }
            }()
            return "\(tag) [\(vr)] = \(rawStr)"
        }
    }
}
