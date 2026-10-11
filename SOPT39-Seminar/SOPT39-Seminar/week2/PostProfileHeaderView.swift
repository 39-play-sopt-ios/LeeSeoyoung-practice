//
//  PostProfileHeaderView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct PostProfileHeaderView: View {
    let username: String
    let location: String
    let profile: Image
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            profile
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
                .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 1) {
                Text("\(username)")
                    .font(.system(size: 13, weight: .bold))
                Text("\(location)")
                    .font(.system(size: 11, weight: .regular))
            }
            
            Spacer()
            
            Image(.moreIcon)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 11)
    }
}

