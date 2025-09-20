//
//  StudyInfoView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct StudyInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 20) {
                Text("검사일")
                    .font(.bold)
                Text("2025.08.01")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("종류")
                    .font(.bold)
                Text("CT")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("장비  제조사")
                    .font(.bold)
                Text("Philips")
                    .font(.medium)
            }
        }
        .padding(.horizontal, 48)
    }
}

#Preview {
    StudyInfoView()
}
