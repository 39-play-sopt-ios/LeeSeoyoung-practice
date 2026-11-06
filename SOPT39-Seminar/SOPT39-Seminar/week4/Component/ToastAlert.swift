//
//  ToastAlert.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import SwiftUI

struct ToastAlert: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.customRed.opacity(0.8))
            .clipShape(Capsule())
            .padding(.top, 5)
            .transition(.move(edge: .top).combined(with: .opacity))
    }
}
