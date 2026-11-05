//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/3/26.
//

import SwiftUI

struct PostListView: View {
    @State private var searchText = ""
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomInputField(text: $searchText, placeholder: "검색어를 입력하세요", icon: "Search")
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
            
            List {
                PostListRow()
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    PostListView()
}
