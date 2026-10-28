//
//  InstagramDMViewModel.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/17/26.
//

import Foundation
import Observation

@Observable
final class InstagramDMViewModel {
    private(set) var exampleDMs: [DMModel] = [
        DMModel(
            profileImageName: "lion",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "지금"
        ),
        DMModel(
            profileImageName: "gini",
            username: "helloworld",
            content: "안녕안녕~~~!!",
            timeText: "1시간 전"
        ),
        DMModel(
            profileImageName: "lion",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "1시간 전"
        ),
        DMModel(
            profileImageName: "lion",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "2시간 전"
        ),
        DMModel(
            profileImageName: "horse",
            username: "horsekim",
            content: "집 가고 싶어",
            timeText: "2시간 전"
        ),
        DMModel(
            profileImageName: "gini",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "3시간 전"
        ),
        DMModel(
            profileImageName: "lion",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "5시간 전"
        ),
        DMModel(
            profileImageName: "gini",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "6시간 전"
        ),
        DMModel(
            profileImageName: "horse",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "6시간 전"
        ),
        DMModel(
            profileImageName: "horse",
            username: "horsekim",
            content: "집 가고 싶어",
            timeText: "2시간 전"
        ),
        DMModel(
            profileImageName: "gini",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "3시간 전"
        ),
        DMModel(
            profileImageName: "lion",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "5시간 전"
        ),
        DMModel(
            profileImageName: "gini",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "6시간 전"
        ),
        DMModel(
            profileImageName: "horse",
            username: "queenlion",
            content: "오늘 저녁 뭐먹을까",
            timeText: "6시간 전"
        )
    ]
}
