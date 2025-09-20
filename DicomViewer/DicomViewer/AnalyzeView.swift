//
//  AnalyzeView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct AnalyzeView: View {
    var body: some View {
        VStack(spacing: 37) {
            // TODO: 샘플 파일 이름으로 변경
            Text("""
                 X-Ray
                 Angiographic
                 Image Storage
                """)
            .font(.medium)
            .foregroundStyle(.accent)
            .multilineTextAlignment(.center)
            
            // TODO: 샘플 파일 이미지로 변경
            Image("dicomImage")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 40)
            
            DetailInfoView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

#Preview {
    AnalyzeView()
}
