//
//  Song.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//
import SwiftUI

struct Song:Identifiable,Hashable{
    var id=UUID().uuidString
    var songName:String
    var songImage:String
    var author:String
}


var sampleSong:[Song]=[
    Song(songName: "summer", songImage: "testpic",author:"久石让")
]
