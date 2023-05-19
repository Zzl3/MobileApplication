//
//  InstruTab.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//

import SwiftUI

struct InstruTab:Identifiable{
    var id: String = UUID().uuidString
    var tabImage:String
    var tabName:String
    var tabOffset:CGSize
}

var tabs:[InstruTab]=[
    .init(tabImage:"Instru_guzheng",tabName:"古筝",tabOffset:CGSize(width: 0, height: -40)),
//    .init(tabImage:"Instru_muyu",tabName:"木鱼",tabOffset:CGSize(width: 0, height: -38)),
    .init(tabImage:"Instru_xiao",tabName:"萧",tabOffset:CGSize(width: 0, height: -35)),
    .init(tabImage:"Instru_di",tabName:"笛子",tabOffset:CGSize(width: 0, height: -25)),
]
