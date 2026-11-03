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
        VStack(alignment: .center, spacing: 20) {
            TextField(
                "part",
                text: $part,
                prompt: Text("web / ios / android")
                    .foregroundStyle(.gray200)
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(16)
            .frame(maxWidth: .infinity)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray200, lineWidth: 2)
            }
            .padding(.horizontal, 24)
            
            TextField(
                "name",
                text: $name,
                prompt: Text("이름을 입력해주세요")
                    .foregroundStyle(.gray200)
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(16)
            .frame(maxWidth: .infinity)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray200, lineWidth: 2)
            }
            .padding(.horizontal, 24)
            
            Button {
                Task {
                    await signupButtonDidTap()
                }
            } label: {
                Text(isLoading ? "발급 중…" : "코드 발급")
                    .foregroundStyle(.white)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
            }
            .padding(.top, 8)
            
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
                .padding(44)
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .padding(24)
            }
        }
        .padding(.top, 130)
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
