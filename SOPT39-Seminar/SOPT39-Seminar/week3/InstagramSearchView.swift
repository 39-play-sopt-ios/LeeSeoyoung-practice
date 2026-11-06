//
//  InstagramSearchView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/17/26.
//

import SwiftUI

struct InstagramSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        
        VStack(spacing: 0) {
            ScrollView {
                searchBar
                    .padding(.bottom, 15)
                
                Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                    ForEach(0..<6, id: \.self) { row in
                        GridRow {
                            ForEach(0..<3, id: \.self) { column in
                                let index = row * 3 + column
                                
                                Color.clear
                                    .aspectRatio(contentMode: .fit)
                                    .overlay {
                                        Image("Rectangle\(index)")
                                            .resizable()
                                            .scaledToFill()
                                    }
                                    .clipped()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var searchBar: some View {
        HStack(alignment: .center, spacing: 13) {
            TextField(
                "검색",
                text: $searchText,
                prompt: Text("검색")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.black.opacity(0.6))
            )
                .font(.system(size: 13, weight: .regular))
                .padding(.horizontal, 15)
                .frame(height: 36)
                .background(.gray100)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray200, lineWidth: 1)
                }
                
            Image(.save)
        }
        .padding(.horizontal, 11)
        .padding(.vertical, 8)
    }
}

#Preview {
    InstagramSearchView()
}
