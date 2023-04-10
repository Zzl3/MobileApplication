//
//  Song.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//
import SwiftUI
import Foundation

import SwiftUI

struct Song: Codable,Identifiable {
    var id: Int
    var name: String
    var artist: String
    var genre: String
    var description: String
    var fileURL: String
    var createdAt: Date
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, artist, genre, description,image
        case fileURL = "file_url"
        case createdAt = "created_at"
    }
    
    // 手动实现一个init
    init(id: Int, name: String, artist: String, genre: String, description: String, fileURL: String, createdAt: Date,image: String) {
            self.id = id
            self.name = name
            self.artist = artist
            self.genre = genre
            self.description = description
            self.fileURL = fileURL
            self.createdAt = createdAt
            self.image = image
    }
    
    // 解码实现一个init
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        genre = try container.decode(String.self, forKey: .genre)
        description = try container.decode(String.self, forKey: .description)
        fileURL = try container.decode(String.self, forKey: .fileURL)
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        createdAt = dateFormatter.date(from: createdAtString) ?? Date()
        image = try container.decode(String.self, forKey: .image)
    }
}

struct SongList: Codable {
    var code: Int
    var data: [Song]
}

let dateComponents = DateComponents(year: 2023, month: 4, day: 10, hour: 15, minute: 0, second: 0)
let calendar = Calendar.current
let sampledate = calendar.date(from: dateComponents)!

var sampleSong:[Song]=[
    Song(id: 0,
         name: "百鸟朝凤",
         artist:"魏子猷",
         genre: "纯音乐，唢呐独奏",
         description: "《百鸟朝凤》外文名为《Hundreds Of Birds Worshipping The Phoenix》，是由民乐大师魏子猷原创，流行于河南、安徽、山东、河北等的民族乐曲。其前身是豫剧抬花轿中的伴奏曲，因为豫剧流行很广，使百鸟朝凤流行于河南、山东、河北、安徽等地，又名《百鸟音》，这是一首充分展示唢呐艺术魅力的优秀乐曲。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",
         createdAt:sampledate,
         image:"testpic"),
]
