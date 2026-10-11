//
//  PostView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct PostView: View {
    @Binding var isLiked: Bool
    let profileImage: Image
    let username: String
    let location: String
    let postImg: Image
    let likesText: String
    let caption: String
    let timeText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PostProfileHeaderView(username: username, location: location, profile: profileImage)
            
            postImage
            
            actionIcons
            
            postInfo
        }
    }
    
    private var postImage: some View {
        ZStack(alignment: .topTrailing) {
            postImg
                .resizable()
                .scaledToFit()
            
            Image(.photoNumber)
                .padding(14)
        }
    }
    
    private var actionIcons: some View {
        HStack(alignment: .center, spacing: 17) {
            Button {
                isLiked.toggle()
            } label: {
                Image(isLiked ? .like : .likeEmpty)
            }
            Image(.comment)
            Image(.messanger)
            Spacer()
            Image(.save)
        }
        .padding(14)
    }
    
    private var postInfo: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(alignment: .center, spacing: 6.5) {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 17, height: 17)
                    .clipShape(.circle)
                Text("\(likesText)")
                    .font(.system(size: 13, weight: .regular))
            }
            .padding(.horizontal, 14)
            
            HStack(alignment: .center, spacing: 6.5) {
                Text("\(username)")
                    .font(.system(size: 13, weight: .bold))
                Text("\(caption)")
                    .font(.system(size: 13, weight: .regular))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            
            Text("\(timeText)")
                .font(.system(size: 11, weight: .regular))
                .foregroundStyle(.gray300)
                .padding(.horizontal, 14)
                .padding(.bottom, 30)
        }
    }
}
