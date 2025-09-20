//
//  ViewModifiers.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

struct FullBackground: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .ignoresSafeArea()
    }
}

extension View {
    func fullBackground(_ color: Color) -> some View {
        self.modifier(FullBackground(color: color))
    }
}
