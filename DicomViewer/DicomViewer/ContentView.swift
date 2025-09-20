//
//  ContentView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 50) {
                Text("DICOM")
                    .font(.large)
                    .foregroundStyle(.accent)
                if #available(iOS 26.0, *) {
                    Button(action: {
                        path.append("LoadingView")
                    }) {
                        Text("파일 분석")
                            .font(.small)
                            .foregroundStyle(.accent)
                            .padding(20)
                            .glassEffect()
                    }
                } else {
                    Button(action: {
                        path.append("LoadingView")
                    }) {
                        Text("파일 분석")
                            .font(.small)
                            .foregroundStyle(.accent)
                            .padding(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.accent, lineWidth: 2)
                            )
                    }
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "LoadingView" {
                    LoadingView()
                }
            }
            .fullBackground(Color("Background"))
        }
    }
}

#Preview {
    ContentView()
}
