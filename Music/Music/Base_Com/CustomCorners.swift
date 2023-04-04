//
//  CustomCorners.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/3.
//

import SwiftUI

//MARK: 常规的形状
struct CustomCorners: Shape {
    var corners:UIRectCorner
    var radius:CGFloat
    func path(in rect:CGRect)->Path{
        let path=UIBezierPath(roundedRect: rect,byRoundingCorners: corners ,cornerRadii: CGSize(width: radius, height: radius))
        return .init(path.cgPath)
    }
}

