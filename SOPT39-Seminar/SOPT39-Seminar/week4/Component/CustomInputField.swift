//
//  CustomInputField.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/3/26.
//

import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    let placeholder: String
    var icon: String? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            TextField(
                text,
                text: $text,
                prompt: Text(placeholder)
                    .foregroundStyle(.gray200)
            )
            
            if let icon {
                Image(icon)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .padding(16)
        .frame(maxWidth: .infinity)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray200, lineWidth: 2)
        }
    }
}
