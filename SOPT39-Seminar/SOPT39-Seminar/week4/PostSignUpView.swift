//
//  PostSignUpView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/31/26.
//

import SwiftUI

struct PostSignUpView: View {
    @State private var part = ""
    @State private var name = ""
    @State private var authorizationCode = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 28) {
                VStack(alignment: .center, spacing: 20) {
                    CustomInputField(text: $part, placeholder: "web / ios / android")
                    
                    CustomInputField(text: $name, placeholder: "이름을 입력해주세요")
                }
                
                Button {
                    Task {
                        await signupButtonDidTap()
                    }
                } label: {
                    PrimaryButtonLabel(text: isLoading ? "발급 중…" : "코드 발급")
                }
                
                NavigationLink {
                    PostListView()
                } label: {
                    PrimaryButtonLabel(text: "게시글 이동")
                }
                
                Spacer()
                
                if !authorizationCode.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("발급받은 인증 코드")
                            .font(.subhead3)
                        Text(authorizationCode)
                            .font(.head1)
                            .textSelection(.enabled)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                }
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding(.vertical, 24)
                }
            }
            .padding(.top, 130)
            .padding(.horizontal, 24)
        }
    }
    
    private func signupButtonDidTap() async {
        guard !isLoading else { return }
        
        isLoading = true
        authorizationCode = ""
        errorMessage = ""
        defer { isLoading = false }
        
        do {
            let response = try await SignupService.shared.postSignup(part: part)
            try Task.checkCancellation()
            
            guard let code = response.data?.authorizationCode else {
                throw NetworkError.responseError
            }
            authorizationCode = code
        } catch is CancellationError {
            // 취소는 사용자에게 요청 실패로 표시하지 않는다
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    PostSignUpView()
}
