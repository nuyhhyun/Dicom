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
    
    var body: some View {
        VStack(spacing: 36) {
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
            
            if selectedSegment == 0 {
                PatientInfoView()
            } else if selectedSegment == 1 {
                StudyInfoView()
            } else {
                FileInfoView()
            }
        }
        .background(Color("Background"))
    }
}

#Preview {
    InfoSegmentationView()
}
