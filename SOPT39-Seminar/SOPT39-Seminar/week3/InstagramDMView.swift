//
//  InstagramDMView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/17/26.
//

import SwiftUI

struct InstagramDMView: View {
    
    @State private var viewModel = InstagramDMViewModel()
    
    var body: some View {
        List(viewModel.exampleDMs) { message in
            InstagramDmRowView(message: message)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    InstagramDMView()
}
