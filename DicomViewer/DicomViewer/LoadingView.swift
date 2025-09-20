//
//  LoadingView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnalyzed = false
    
    var body: some View {
        if isAnalyzed {
            AnalyzeView()
                .transition(.opacity)
        } else {
            VStack(spacing: 30) {
                ProgressView()
                    .scaleEffect(2.0)
                    .tint(.accent)
                    .frame(width: 60, height: 60)
                
                Text("샘플 파일을 분석 중입니다.")
                    .font(.small)
            }
            .transition(.opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isAnalyzed = true
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoadingView()
}
