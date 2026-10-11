//
//  PostModel.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/10/26.
//

import Foundation

struct PostModel: Identifiable {
    let id = UUID()
    let username: String
    let location: String
    let postImageName: String
    let likesText: String
    let caption: String
    let timeText: String
    var isLiked = false
}

let examplePosts: [PostModel] = [
    PostModel(
        username: "seoyoung",
        location: "화성시",
        postImageName: "lion",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "벌써 2차 세미나라니 정말 즐거워요!",
        timeText: "1시간 전"
    ),
    PostModel(
        username: "horse",
        location: "California",
        postImageName: "horse",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "같은 카드에 다른 데이터를 전달해보기~",
        timeText: "2시간 전"
    ),
    PostModel(
        username: "기니피그",
        location: "서울",
        postImageName: "gini",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "같은 카드에 다른 데이터를 전달해보기~",
        timeText: "2시간 전"
    )
]
