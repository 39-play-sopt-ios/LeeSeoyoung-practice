//
//  PostListRow.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/4/26.
//

import SwiftUI

struct PostListRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 4) {
                Text("닉네임")
                
                Rectangle()
                    .frame(width: 1, height: 12)
                
                Text("YYYY.MM.DD")
            }
            .font(.body1)
            .foregroundStyle(.gray300)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("제목")
                    .font(.pretendard(.medium, size: 16))
                Text("본문입니다 본문입니다 본문입니다 본문입니다 본문입니다 본문입니다 본문입니다 본문입니다 본문입니다")
                    .font(.subhead4)
            }
            .foregroundStyle(.gray500)
        }
        .padding(20)
        .background(.gray100)
        .cornerRadius(20)
    }
}
