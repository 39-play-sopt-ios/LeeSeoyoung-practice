//
//  PrimaryButtonLabel.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/3/26.
//

import SwiftUI

struct PrimaryButtonLabel: View {
    let text: String
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
    
    var body: some View {
        Text(text)
            .foregroundStyle(foregroundColor)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(.capsule)
    }
}
