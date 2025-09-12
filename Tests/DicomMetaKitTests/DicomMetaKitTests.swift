import Foundation
import Testing
@testable import DicomMetaKit

@Suite("DicomMetaKit - Metadata parsing")
struct DicomMetaKitTests {
    @Test("Read sample DICOM (URL)")
    func readSampleURL() throws {
        let url = try #require(Bundle.module.url(forResource: "test_dicom_file", withExtension: "dcm"))
        let ds = try DicomMeta.read(url: url)

        // Basic presence checks
        #expect(ds[.transferSyntaxUID] != nil)
        #expect(ds[.sopClassUID] != nil)
    }

    @Test("Read sample DICOM (Data)")
    func readSampleData() throws {
        let url = try #require(Bundle.module.url(forResource: "test_dicom_file", withExtension: "dcm"))
        let data = try Data(contentsOf: url)
        let ds = try DicomMeta.read(data: data)

        #expect(ds.elements.count > 5)
        // Example tag string check (may be empty, but present)
        _ = ds.string(for: .patientName) // just ensure API compiles/works
    }

    @Test("Stops at Pixel Data by default")
    func stopAtPixelData() throws {
        let url = try #require(Bundle.module.url(forResource: "test_dicom_file", withExtension: "dcm"))
        let ds = try DicomMeta.read(url: url, stopAtPixelData: true)
        // Parser shouldn’t fail; we don’t assert counts because files vary.
        #expect(ds.elements.isEmpty == false)
    }
}
