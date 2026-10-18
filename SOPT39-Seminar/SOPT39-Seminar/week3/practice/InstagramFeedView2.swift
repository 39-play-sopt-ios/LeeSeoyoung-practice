//
//  InstagramFeedView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct InstagramFeedView2: View {
    @State private var viewModel = InstagramFeedViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Image(.instagramLogo)
                
                ForEach(viewModel.examplePosts) { post in
                    PostView2(profileImage: Image(post.postImageName),
                             username: post.username,
                             location: post.location,
                             postImg: Image(post.postImageName),
                             likesText: post.likesText,
                             caption: post.caption,
                             timeText: post.timeText,
                             isLiked: post.isLiked,
                             onLikedTapped: {
                                viewModel.toggleLike(id: post.id)
                            })
                }
            }
        }
    }
}

#Preview {
    InstagramFeedView()
}
