//
//  MemberListView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct MemberListView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink("주희 상세 보기", value: "주희")
                NavigationLink("서영 상세 보기", value: "서영")
            }
            .navigationTitle("파트원")
            .navigationDestination(for: String.self) { name in
                MemberDetailView(name: name)
            }
        }
    }
}

#Preview {
    MemberListView()
}
