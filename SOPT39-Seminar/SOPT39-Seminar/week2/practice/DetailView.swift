//
//  DetailView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
            
        Text("상세 화면")
            .font(.title)
            .navigationTitle("상세")
            
        NavigationLink {
            ProfileView()
        } label: {
            Text("프로필 화면으로 이동")
        }
    }
}

#Preview {
    DetailView()
}
