//
//  PostCreateBottomSheet.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import SwiftUI

struct PostCreateBottomSheet: View {
    @State private var title = ""
    @State private var content = ""
    
    let author: String
    let authorizationCode: String
    
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    @Environment(\.dismiss) private var dismiss
    
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
                        await postButtonDidTap()
                    }
                } label: {
                    PrimaryButtonLabel(
                        text: "완료",
                        foregroundColor: isFormValid ? .white : .gray300,
                        backgroundColor: isFormValid ? .black : .gray100
                    )
                }
                .disabled(!isFormValid)
            }
            .padding(16)
        }
        .ignoresSafeArea()
    }
    
    private var isFormValid: Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return !trimmedTitle.isEmpty
        && !trimmedContent.isEmpty
        && title.count <= 20
        && content.count <= 100
    }
    
    private func postButtonDidTap() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = ""
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
            errorMessage = error.localizedDescription
        }
    }
}
