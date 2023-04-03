//
//  CustomTab.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/3.
//

import SwiftUI

struct CustomTab: Shape {
    var curveAxis: CGFloat
    func path(in rect: CGRect) -> Path {
        return Path{
            path in
            let height = rect.height - 100
            let pt1 = CGPoint(x: 0,y: 0)
            let pt2 = CGPoint(x: rect.width,y: 0)
            let pt3 = CGPoint(x: rect.width,y: height)
            let pt4 = CGPoint(x: 0,y: height)
            
            path.move(to: pt1)
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 0)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 0)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 40)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 40)
            
            let mid = curveAxis
            let curve = rect.height - 50
            path.move(to: CGPoint(x:mid - 60,y: height))
            let to1 = CGPoint(x: mid, y: curve)
            let control1 = CGPoint(x: mid - 30, y: height)
            let control2 = CGPoint(x: mid - 30, y: curve)
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: mid + 60, y: height)
            let control3 = CGPoint(x: mid + 30, y: curve)
            let control4 = CGPoint(x: mid + 30, y: height)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

