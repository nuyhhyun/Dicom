//
//  AnalyzeView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct AnalyzeView: View {
    var body: some View {
        VStack(spacing: 48) {
            // TODO: 샘플 파일 이름으로 변경
            Text("""
                 X-Ray
                 Angiographic
                 Image Storage
                """)
            .font(.bold)
            .foregroundStyle(.accent)
            .multilineTextAlignment(.center)
            .padding(.top, 88)
            
            // TODO: 샘플 파일 이미지로 변경
            Image("dicomImage")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 40)
            
            InfoSegmentationView()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

#Preview {
    AnalyzeView()
}
