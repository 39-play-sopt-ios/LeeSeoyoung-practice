//
//  PostListResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import Foundation

struct PostListResponseDTO: Decodable {
    let isSuccess: Bool?
    let code: String?
    let message: String?
    let data: PostListData?
    
    struct PostListData: Decodable {
        let posts: [PostData]?
        let nextCursor: Int64?
        let hasNext: Bool?
    }
    
    struct PostData: Decodable {
        let id: Int64?
        let title: String?
        let content: String?
        let author: String?
        let createdAt: String?
        let updatedAt: String?
    }
}
