//
//  AnalyzeView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct AnalyzeView: View {
    var body: some View {
        VStack(spacing: 20) {
            // TODO: 샘플 파일 이름으로 변경
            Text("""
                Ultrasound
                Multi-frame
                Image Storage
                """)
            .font(.bold)
            .foregroundStyle(.accent)
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            
            // TODO: 샘플 파일 이미지로 변경
            Image("dicomImage")
                .resizable()
                .scaledToFit()
                .frame(height: 280)
                .padding(.horizontal, 40)
            
            InfoSegmentationView()
            
            Spacer()
        }
        .fullBackground(Color("Background"))
    }
}

#Preview {
    AnalyzeView()
}
