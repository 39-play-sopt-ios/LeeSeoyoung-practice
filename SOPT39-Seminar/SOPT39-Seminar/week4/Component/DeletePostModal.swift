//
//  DeletePostModal.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import SwiftUI

struct DeletePostModal: View {
    let onCancel: () -> Void
    let onDelete: () -> Void
    let isDeleting: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("게시물을 삭제할까요?")
                .font(.medium)
            
            HStack(alignment: .center, spacing: 12) {
                Button {
                    onCancel()
                } label: {
                    PrimaryButtonLabel(
                        text: "취소",
                        foregroundColor: .gray500,
                        backgroundColor: .gray100
                    )
                }
                .disabled(isDeleting)
                
                Button {
                    onDelete()
                } label: {
                    PrimaryButtonLabel(text: isDeleting ? "삭제 중..." : "삭제")
                }
                .disabled(isDeleting)
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(12)
    }
}
