//
//  ContentView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 65) {
            Spacer()
            
            Image(.instagramLogo)
            
            VStack(spacing: 12) {
                Image(.profile)
                
                Text("moamoa")
                
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
                .padding(.horizontal, 34)
                
                Button {
                    // acount change
                } label: {
                    Text("계정 전환")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.primaryBlue)
                        .padding(.top, 18)
                }
            }
            
            Spacer()
            
            HStack {
                Text("계정이 없으신가요?")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.gray300)

                Button {
                    // new account
                } label: {
                    Text("회원가입하기")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.instaBlack)
                }
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ContentView()
}
