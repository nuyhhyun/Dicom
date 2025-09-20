//
//  InfoSegmentationView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI
import DicomMetaKit

struct InfoSegmentationView: View {
    @State private var selectedSegment = 0
    @StateObject private var viewModel = InfoSegmentationViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            Picker("", selection: $selectedSegment) {
                Text("환자").tag(0)
                    .font(.small)
                Text("검사").tag(1)
                    .font(.small)
                Text("파일").tag(2)
                    .font(.small)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            
            if let dataset = viewModel.dataset {
                if selectedSegment == 0 {
                    PatientInfoView(dataset: dataset)
                } else if selectedSegment == 1 {
                    StudyInfoView(dataset: dataset)
                } else {
                    FileInfoView(dataset: dataset)
                }
            } else {
                Text(viewModel.errorMessage ?? "Loading...")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.loadDicom(named: "sample")
        }
    }
}

#Preview {
//    InfoSegmentationView()
}
