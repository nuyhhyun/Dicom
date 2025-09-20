//
//  StringFormat.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI

extension String {
    func formattedDate() -> String? {
        guard self.count == 8 else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        
        guard let date = formatter.date(from: self) else { return nil }
        return formatter.string(from: date)
    }
    
    func onlyAlphabets() -> String {
        return self.filter { $0.isLetter }
    }
}
