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
    Album(id: 2,albumName: "笙", albumImage: "Instru_sheng",introduction:"笙简单介绍"),
    Album(id: 3,albumName: "扬琴", albumImage: "Instru_yangqin",introduction:"扬琴简单介绍"),
    //Album(albumName: "木鱼", albumImage: "Instru_muyu",introduction:"木鱼简单介绍"),
]

