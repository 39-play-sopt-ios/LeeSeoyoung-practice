//
//  MemberDetailView.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import SwiftUI

struct MemberDetailView: View {
    let name: String

    var body: some View {
        Text("\(name)의 상세 화면")
            .font(.title)
            .navigationTitle(name)
    }
}


