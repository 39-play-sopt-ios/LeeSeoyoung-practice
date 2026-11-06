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
                    // create
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
}

#Preview {
    PostCreateBottomSheet()
}
