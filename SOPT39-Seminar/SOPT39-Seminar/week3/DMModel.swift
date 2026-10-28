//
//  DMModel.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/17/26.
//

import Foundation

struct DMModel: Identifiable {
    let id = UUID()
    let profileImageName: String
    let username: String
    let content: String
    let timeText: String
}
