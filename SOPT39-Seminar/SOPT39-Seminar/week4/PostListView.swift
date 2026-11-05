//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/3/26.
//

import SwiftUI

struct PostListView: View {
    @State private var posts: [PostListResponseDTO.PostData] = []
    @State private var errorMessage: String?
    
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomInputField(text: $searchText, placeholder: "검색어를 입력하세요", icon: "Search")
                .padding(.vertical, 12)
            
            List(posts, id: \.id) { post in
                PostListRow(
                    title: post.title,
                    content: post.content,
                    author: post.author,
                    createdAt: post.createdAt
                )
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            .listRowSpacing(12)
            .task {
                await fetchPosts()
            }

            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .padding()
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func fetchPosts() async {
        do {
            let response = try await PostService.shared.fetchPosts()
            posts = response.data?.posts ?? []
        } catch is CancellationError {
            // 화면을 벗어나 요청이 취소된 경우
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    PostListView()
}
