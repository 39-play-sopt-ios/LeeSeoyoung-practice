//
//  SheetPracticeView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct SheetPracticeView: View {
    @State private var showSheet = false
    
    var body: some View {
        Button("시트 열기") {
            showSheet = true
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showSheet) {
        
        VStack(spacing: 20) {
            Text("아래에서 올라온 화면이에요!")
                .font(.title2)
            
            Button("닫기") {
                showSheet = false
            }
        }
        .padding()
        .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    SheetPracticeView()
}
