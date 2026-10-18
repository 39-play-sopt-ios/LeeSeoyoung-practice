//
//  InstagramDmRowView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/17/26.
//

import SwiftUI

struct InstagramDmRowView: View {
    
    var message: DMModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(message.profileImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(.circle)
                .padding(.trailing, 12)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(message.username)
                
                HStack {
                    Text(message.content)
                    Spacer()
                    Text(message.timeText)
                }
                .foregroundStyle(.gray300)
            }
            .font(.system(size: 13, weight: .regular))
            
            Spacer()

            Image(.picture)
                .padding(.leading, 32)
        }
    }
}
