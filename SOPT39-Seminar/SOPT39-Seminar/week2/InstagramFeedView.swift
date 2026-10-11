//
//  InstagramFeedView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct InstagramFeedView: View {
    @State private var posts: [PostModel] = examplePosts
    
    var body: some View {
        ScrollView {
            VStack {
                Image(.instagramLogo)
                
                ForEach($posts) { $post in
                    FeedView(isLiked: $post.isLiked,
                             profileImage: Image(post.postImageName),
                             username: post.username,
                             location: post.location,
                             postImg: Image(post.postImageName),
                             likesText: post.likesText,
                             caption: post.caption,
                             timeText: post.timeText)
                }
            }
        }
    }
}

#Preview {
    InstagramFeedView()
}
