//
//  PatientInfoView.swift
//  DicomViewer
//
//  Created by 이서현 on 9/20/25.
//

import SwiftUI
import DicomMetaKit

struct PatientInfoView: View {
    let dataset: DicomDataset
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 20) {
                Text("ID")
                    .font(.bold)
                Text(dataset.string(for: .patientID) ?? "Non-public information")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("이름")
                    .font(.bold)
                Text(dataset.string(for: .patientID)?.onlyAlphabets() ?? "Anonymous")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("생년월일")
                    .font(.bold)
                Text(dataset.string(for: .patientBirthDate)?.formattedDate() ?? "Non-public information")
                    .font(.medium)
            }
            Divider()
            HStack(spacing: 20) {
                Text("성별")
                    .font(.bold)
                Text(dataset.string(for: .patientSex) ?? "Non-public information")
                    .font(.medium)
            }
        }
        .padding(.horizontal, 40)
    }
}

//#Preview {
//    PatientInfoView()
//}
