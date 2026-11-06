//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/3/26.
//

import SwiftUI

struct PostListView: View {
    private enum PostSheet: Identifiable {
        case create
        case edit(PostListResponseDTO.PostData)
        
        var id: String {
            switch self {
            case .create:
                return "create"
            case .edit(let post):
                return "edit-\(post.id ?? 0)"
            }
        }
    }
    
    let author: String
    let authorizationCode: String
    
    @State private var posts: [PostListResponseDTO.PostData] = []
    @State private var searchText = ""
    @State private var activeSheet: PostSheet?
    @State private var selectedPost: PostListResponseDTO.PostData?
    @State private var showDeleteModal = false
    @State private var toastMessage: String?
    @State private var nextCursor: Int64?
    @State private var hasNext = true
    @State private var isLoadingPage = false
    @State private var isDeletingPost = false
    @State private var hasLoadedPosts = false
    
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
                    .onTapGesture {
                        selectedPost = post
                        activeSheet = .edit(post)
                    }
                    .onAppear {
                        guard post.id == posts.last?.id else { return }

                        Task {
                            let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                            await fetchPage(keyword: keyword)
                        }
                    }
                }
                .listStyle(.plain)
                .listRowSpacing(12)
                .overlay {
                    if hasLoadedPosts
                        && posts.isEmpty
                        && !isLoadingPage
                        && !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text("검색 결과가 없습니다.")
                            .foregroundStyle(.gray300)
                            .allowsHitTesting(false)
                    }
                }
                .task(id: searchText) {
                    let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

                    guard keyword.isEmpty || (2...50).contains(keyword.count) else {
                        return
                    }
                    
                    do {
                        try await Task.sleep(nanoseconds: 300_000_000)
                        await fetchPage(keyword: keyword, isNewSearch: true)
                    } catch is CancellationError {
                        // 입력이 다시 바뀌어 이전 대기 작업이 취소된 경우
                    } catch {
                        showToast(error.localizedDescription)
                    }
                }
            }
            .padding(.horizontal, 16)
            
            Button {
                activeSheet = .create
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
            .sheet(item: $activeSheet, onDismiss: {
                Task {
                    await fetchPage(keyword: searchText, isNewSearch: true)
                }
            }) { sheet in
                switch sheet {
                case .create:
                    PostBottomSheet(mode: .create, author: author, authorizationCode: authorizationCode)
                        .presentationDetents([.fraction(0.4)])
                case .edit(let post):
                    PostBottomSheet(mode: .edit(post), author: author, authorizationCode: authorizationCode)
                        .presentationDetents([.fraction(0.4)])
                }
            }
            
            if showDeleteModal, let selectedPost {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showDeleteModal = false
                        }
                    
                    DeletePostModal(onCancel: {
                        showDeleteModal = false
                    }, onDelete: {
                        Task {
                            guard await deletePost(id: selectedPost.id) else { return }
                            showDeleteModal = false
                            let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                            await fetchPage(keyword: keyword, isNewSearch: true)
                        }
                    }, isDeleting: isDeletingPost)
                    .padding(36)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(1)
            }
        }
        .overlay(alignment: .top) {
            if let toastMessage {
                ToastAlert(message: toastMessage)
            }
        }
    }
    
    private func deletePost(id: Int64?) async -> Bool {
        guard !isDeletingPost else { return false }

        isDeletingPost = true
        defer { isDeletingPost = false }

        do {
            _ = try await PostService.shared.deletePost(id: id, authorizationCode: authorizationCode)
            return true
        } catch is CancellationError {
            // 화면을 벗어나 요청이 취소된 경우
            return false
        } catch {
            showToast(error.localizedDescription)
            return false
        }
    }
    
    private func fetchPage(keyword: String, isNewSearch: Bool = false) async {
        guard !isLoadingPage else { return }
        guard isNewSearch || hasNext else { return }

        isLoadingPage = true
        if isNewSearch {
            hasLoadedPosts = false
        }
        defer { isLoadingPage = false }

        do {
            let cursor = isNewSearch ? nil : nextCursor
            let response = try await PostService.shared.fetchPosts(
                keyword: keyword,
                cursor: cursor
            )
            try Task.checkCancellation()

            let page = response.data
            let newPosts = page?.posts ?? []

            if isNewSearch {
                posts = newPosts
            } else {
                posts.append(contentsOf: newPosts)
            }

            nextCursor = page?.nextCursor
            hasNext = page?.hasNext ?? false
            hasLoadedPosts = true
        } catch is CancellationError {
            // 취소된 요청은 무시
        } catch {
            showToast(error.localizedDescription)
        }
    }
    
    private func showToast(_ message: String) {
        withAnimation {
            toastMessage = message
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation {
                toastMessage = nil
            }
        }
    }
}
