//
//  LikeStatePracticeView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct LikeStatePracticeView: View {
    @State private var isLiked = false

    var body: some View {
    
        VStack(spacing: 16) {
        
            Text(isLiked ? "좋아요를 눌렀어요" : "아직 좋아요를 누르지 않았어요")
            
            LikeButtonView(isLiked: $isLiked)
        }
        .padding()
    }
}

#Preview {
    LikeStatePracticeView()
}
