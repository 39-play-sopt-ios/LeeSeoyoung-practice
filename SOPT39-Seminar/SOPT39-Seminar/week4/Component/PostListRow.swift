//
//  PostListRow.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/4/26.
//

import SwiftUI

struct PostListRow: View {
    let title: String?
    let content: String?
    let author: String?
    let createdAt: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 4) {
                Text(author ?? "unknown")
                
                Rectangle()
                    .frame(width: 1, height: 12)
                
                Text(formattedCreatedAt)
                
                Spacer()
            }
            .font(.body1)
            .foregroundStyle(.gray300)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title ?? "unknown")
                    .font(.pretendard(.medium, size: 16))
                Text(content ?? "unknown")
                    .font(.subhead4)
            }
            .foregroundStyle(.gray500)
        }
        .padding(20)
        .background(.gray100)
        .cornerRadius(20)
    }
    
    private var formattedCreatedAt: String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.dateFormat = "yyyy.MM.dd"
        
        guard let date = inputFormatter.date(from: createdAt ?? "") else {
            return createdAt ?? "0000.00.00"
        }

        return outputFormatter.string(from: date)
    }
}
