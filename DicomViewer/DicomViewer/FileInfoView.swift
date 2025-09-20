//
//  FileInfoView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct FileInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 20) {
                Text("이미지 ID")
                    .font(.bold)
                Text("789456123")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("검사 단위 ID")
                    .font(.bold)
                Text("789456123")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("시리즈 단위 ID")
                    .font(.bold)
                Text("789456123")
                    .font(.medium)
            }
        }
        .padding(.horizontal, 48)
    }
}

#Preview {
    FileInfoView()
}
