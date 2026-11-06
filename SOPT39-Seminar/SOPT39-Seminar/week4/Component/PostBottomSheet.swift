//
//  PostBottomSheet.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import SwiftUI

struct PostBottomSheet: View {
    enum Mode {
        case create
        case edit(PostListResponseDTO.PostData)
    }
    
    let mode: Mode
    
    @State private var title = ""
    @State private var content = ""
    
    let author: String
    let authorizationCode: String
    
    @State private var isLoading = false
    @State private var toastMessage: String?
    
    @Environment(\.dismiss) private var dismiss
    
    init(mode: Mode, author: String, authorizationCode: String) {
        self.mode = mode
        self.author = author
        self.authorizationCode = authorizationCode

        switch mode {
        case .create:
            _title = State(initialValue: "")
            _content = State(initialValue: "")
        case .edit(let post):
            _title = State(initialValue: post.title ?? "")
            _content = State(initialValue: post.content ?? "")
        }
    }
    
    var body: some View {
        ZStack {
            Color(.white)
            
            VStack(alignment: .center, spacing: 20) {
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("제목")
                            .font(.subhead2)
                            .padding(.leading, 8)
                        
                        CustomInputField(text: $title, placeholder: "제목을 입력하세요.")
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("본문")
                            .font(.subhead2)
                            .padding(.leading, 8)
                        
                        CustomInputField(text: $content, placeholder: "본문을 입력하세요.")
                    }
                }
                
                Button {
                    Task {
                        switch mode {
                        case .create:
                            await createPost()
                        case .edit(let postData):
                            await updatePost(id: postData.id)
                        }
                    }
                } label: {
                    PrimaryButtonLabel(
                        text: isLoading ? "등록 중..." : "완료",
                        foregroundColor: isFormValid ? .white : .gray300,
                        backgroundColor: isFormValid ? .black : .gray100
                    )
                }
                .disabled(!isFormValid || isLoading)
            }
            .padding(16)
        }
        .ignoresSafeArea()
        .overlay(alignment: .top) {
            if let toastMessage {
                ToastAlert(message: toastMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return !trimmedTitle.isEmpty
        && !trimmedContent.isEmpty
        && title.count <= 20
        && content.count <= 100
    }
    
    private func createPost() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let _ = try await PostService.shared.createPost(
                title: title,
                content: content,
                author: author,
                authorizationCode: authorizationCode
            )
            try Task.checkCancellation()
            dismiss()
            
        } catch is CancellationError {
            // 취소는 사용자에게 요청 실패로 표시하지 않는다
        } catch {
            showToast(error.localizedDescription)
        }
    }
    
    private func updatePost(id: Int64?) async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let _ = try await PostService.shared.updatePost(
                id: id,
                authorizationCode: authorizationCode,
                title: title,
                content: content
            )
            try Task.checkCancellation()
            dismiss()
        } catch is CancellationError {
            // 취소는 사용자에게 요청 실패로 표시하지 않는다
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
