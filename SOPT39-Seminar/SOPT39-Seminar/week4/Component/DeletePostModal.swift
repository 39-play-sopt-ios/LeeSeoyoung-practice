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
                
                Button {
                    onDelete()
                } label: {
                    PrimaryButtonLabel(text: "삭제")
                }
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(12)
    }
}
