//
//  InfoViewModel.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI
import DicomMetaKit

@MainActor
class InfoSegmentationViewModel: ObservableObject {
    @Published var dataset: DicomDataset?
    @Published var errorMessage: String?
    
    func loadDicom(named name: String, withExtension ext: String = "dcm") {
        do {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                let data = try DicomMeta.read(url: url)
                self.dataset = data
            } else {
                errorMessage = "DICOM file not found in bundle"
            }
        } catch {
            errorMessage = "Failed to parse DICOM: \(error)"
        }
    }
}
