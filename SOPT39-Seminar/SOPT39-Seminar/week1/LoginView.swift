//
//  LoginView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/3/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        
        VStack(spacing: 0) {
            
            Spacer()
                .frame(height: 126)
            
            Image(.instagramLogo)
                .padding(.bottom, 44)
            
            VStack(spacing: 12) {
                
                TextField(
                    "이메일",
                    text: $email,
                    prompt: Text("이메일")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.black.opacity(0.2))
                )
                    .font(.system(size: 14, weight: .regular))
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 15)
                    .frame(height: 44)
                    .background(.gray100)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray200, lineWidth: 0.5)
                    }
                    .padding(.horizontal, 16)
                
                SecureField(
                    "비밀번호",
                    text: $password,
                    prompt: Text("비밀번호")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.black.opacity(0.2))
                )
                    .font(.system(size: 14, weight: .regular))
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 15)
                    .frame(height: 44)
                    .background(.gray100)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray200, lineWidth: 0.5)
                    }
                    .padding(.horizontal, 16)
            }
            
            Button {
                // login
            } label: {
                Text("로그인하기")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.primaryBlue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
            }
            .padding(.horizontal, 16)
            .padding(.top, 63)
            
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
