//
//  Card.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/19.
//

import SwiftUI

struct Card: Identifiable{
    var id:String=UUID().uuidString
    var cardImage:String
    var rotation:CGFloat=0
}
