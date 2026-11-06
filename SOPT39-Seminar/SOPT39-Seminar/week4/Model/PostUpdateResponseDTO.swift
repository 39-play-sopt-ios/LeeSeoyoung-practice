//
//  PostUpdateResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import Foundation

struct PostUpdateResponseDTO: Decodable {
    let isSuccess: Bool?
    let code: String?
    let message: String?
    let Data: PostData?
    
    struct PostData: Decodable {
        let id: Int64
        let title: String?
        let content: String?
        let author: String?
        let createdAt: String?
        let updatedAt: String?
    }
}
