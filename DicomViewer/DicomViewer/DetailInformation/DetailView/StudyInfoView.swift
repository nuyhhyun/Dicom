//
//  StudyInfoView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI
import DicomMetaKit

struct StudyInfoView: View {
    let dataset: DicomDataset
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 20) {
                Text("검사일")
                    .font(.bold)
                Text(dataset.string(for: .studyDate)?.formattedDate() ?? "Non-public information")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("종류")
                    .font(.bold)
                Text(dataset.string(for: .modality) ?? "Non-public information")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("장비  제조사")
                    .font(.bold)
                Text(dataset.string(for: .manufacturer) ?? "Non-public information")
                    .font(.medium)
            }
        }
        .padding(.horizontal, 48)
    }
}

//#Preview {
//    StudyInfoView()
//}
