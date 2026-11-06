//
//  PostCreateRequestDTO.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import Foundation

struct PostCreateRequestDTO: Encodable {
    let title: String?
    let content: String?
    let author: String?
}
