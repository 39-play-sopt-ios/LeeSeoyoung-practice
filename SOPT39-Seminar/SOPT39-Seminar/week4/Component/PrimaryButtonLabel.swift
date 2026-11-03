//
//  PrimaryButtonLabel.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/3/26.
//

import SwiftUI

struct PrimaryButtonLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(.black)
            .cornerRadius(12)
    }
}
