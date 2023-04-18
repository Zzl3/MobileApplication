//
//  History.swift
//  Music
//
//  Created by sihhd on 2023/4/10.
//

import Foundation

struct History:Identifiable{
    var id=UUID().uuidString
    var song:Song
    var time:String
    var album:Album
}

//var sampleHistorys:[History]=[
//    History(song: Song(name: "summer", songImage: "testpic",artist:"久石让",description: "Summer",file_url: ""), time: "2023-4-10", album: Album(albumName: "古筝", albumImage: "Instru_guzheng",introduction:"古筝简单介绍")),
//    History(song: Song(name: "test", songImage: "testpic",artist:"test",description: "test",file_url: "test2"), time: "2023-4-9", album: Album(albumName: "笙", albumImage: "Instru_sheng",introduction:"笙简单介绍"))
//]


