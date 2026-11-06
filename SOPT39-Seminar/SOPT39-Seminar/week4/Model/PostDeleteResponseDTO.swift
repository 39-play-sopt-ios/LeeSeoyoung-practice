//
//  PostDeleteResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import Foundation

struct PostDeleteResponseDTO: Decodable {
    let isSuccess: Bool?
    let code: String?
    let message: String?
}
