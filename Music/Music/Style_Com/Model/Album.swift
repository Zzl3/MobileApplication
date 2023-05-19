//
//  Album.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/3.
//

import SwiftUI

struct Album:Identifiable,Hashable{
    var id: Int
    var albumName:String
    var albumImage:String
    var introduction:String
}

var sampleAlbums:[Album]=[
    Album(id: 1,albumName: "古筝", albumImage: "Instru_guzheng",introduction:"古筝简单介绍"),
    Album(id: 2,albumName: "萧", albumImage: "Instru_xiao",introduction:"萧简单介绍"),
    Album(id: 3,albumName: "笛子", albumImage: "Instru_di",introduction:"笛子简单介绍"),
    //Album(albumName: "木鱼", albumImage: "Instru_muyu",introduction:"木鱼简单介绍"),
]

