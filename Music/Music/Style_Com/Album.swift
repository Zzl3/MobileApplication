//
//  Album.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/3.
//

import SwiftUI

struct Album:Identifiable{
    var id=UUID().uuidString
    var albumName:String
    var albumImage:String
    var rating:Int
    var introduction:String
}

var sampleAlbums:[Album]=[
    Album(albumName: "古筝", albumImage: "Instru_guzheng", rating: 4,introduction:"用古筝来作为转换后的乐器目前已经非常成熟，其风格为大气"),
    Album(albumName: "笙", albumImage: "Instru_sheng", rating: 5,introduction:"或者改成用户评论也可以？？？"),
    Album(albumName: "扬琴", albumImage: "Instru_yangqin", rating: 4,introduction:"或者改成用户评论也可以？？？"),
]

