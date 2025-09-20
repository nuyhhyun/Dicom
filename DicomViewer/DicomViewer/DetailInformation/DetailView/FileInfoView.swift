//
//  FileInfoView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI
import DicomMetaKit

struct FileInfoView: View {
    let dataset: DicomDataset
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 20) {
                Text("이미지 ID")
                    .font(.bold)
                Text(dataset.string(for: .sopInstanceUID)?.prefix(32) ?? "Non-public information")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("검사 단위 ID")
                    .font(.bold)
                Text(dataset.string(for: .studyInstanceUID) ?? "Non-public information")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("시리즈 단위 ID")
                    .font(.bold)
                Text(dataset.string(for: .seriesInstanceUID) ?? "Non-public information")
                    .font(.medium)
            }
        }
        .padding(.horizontal, 48)
    }
}

//#Preview {
//    FileInfoView()
//}
