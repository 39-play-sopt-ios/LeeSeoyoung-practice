//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/3/26.
//

import SwiftUI

struct PostListView: View {
    let author: String
    let authorizationCode: String
    
    @State private var posts: [PostListResponseDTO.PostData] = []
    @State private var errorMessage: String?
    
    @State private var searchText = ""
    @State private var showSheet = false
    
    @State private var selectedPost: PostListResponseDTO.PostData?
    @State private var showDeleteModal = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                    .onLongPressGesture {
                        selectedPost = post
                        showDeleteModal = true
                    }
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
            
            Button {
                showSheet = true
            } label: {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(.customRed)
                        .frame(width: 60, height: 60)
                    
                    Image(.plus)
                        .frame(width: 28, height: 28)
                }
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 4)
            }
            .padding(16)
            .sheet(isPresented: $showSheet, onDismiss: {
                Task {
                    await fetchPosts()
                }
            }) {
                PostCreateBottomSheet(author: author, authorizationCode: authorizationCode)
                    .presentationDetents([.fraction(0.4)])
            }
            
            if showDeleteModal, let selectedPost {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showDeleteModal = false
                        }
                    
                    DeletePostModal {
                        showDeleteModal = false
                        Task {
                            await fetchPosts()
                        }
                    } onDelete: {
                        Task {
                            await deletePost(id: selectedPost.id)
                            await fetchPosts()
                        }
                        showDeleteModal = false
                    }
                    .padding(36)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(1)
            }
        }
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
    
    private func deletePost(id: Int64?) async {
        do {
            let response = try await PostService.shared.deletePost(id: id, authorizationCode: authorizationCode)
        } catch is CancellationError {
            // 화면을 벗어나 요청이 취소된 경우
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
