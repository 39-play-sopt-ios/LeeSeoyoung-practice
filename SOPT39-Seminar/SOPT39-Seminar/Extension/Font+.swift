//
//  Font+.swift
//  SOPT39-Assignment
//
//  Created by Seoyoung Lee on 10/15/26.
//

import SwiftUI

enum PretendardWeight: String, CaseIterable {
    case thin       = "Pretendard-Thin"
    case extraLight = "Pretendard-ExtraLight"
    case light      = "Pretendard-Light"
    case regular    = "Pretendard-Regular"
    case medium     = "Pretendard-Medium"
    case semiBold   = "Pretendard-SemiBold"
    case bold       = "Pretendard-Bold"
    case extraBold  = "Pretendard-ExtraBold"
    case black      = "Pretendard-Black"
}

extension Font {
    static func pretendard(_ weight: PretendardWeight, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size)
    }
}

extension Font {
    static let head1 = pretendard(.bold, size: 28)
    static let head2 = pretendard(.semiBold, size: 23)
    static let head3 = pretendard(.semiBold, size: 20)
 
    static let subhead1 = pretendard(.semiBold, size: 18)
    static let subhead2 = pretendard(.semiBold, size: 16)
    static let subhead3 = pretendard(.semiBold, size: 14)
    static let subhead4 = pretendard(.medium, size: 14)
 
    static let body1 = pretendard(.medium, size: 12)
    static let body2 = pretendard(.regular, size: 12)
 
    static let cap1 = pretendard(.medium, size: 12)
    static let cap2 = pretendard(.regular, size: 11)
    
    static let medium = pretendard(.medium, size: 18)
}
