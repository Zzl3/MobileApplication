//
//  Collection.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/18.
//

import SwiftUI
import Foundation

struct Collection: Codable,Identifiable {
    var id: Int
    var originId: Int
    var instrumentId: Int
    var transedUrl: String
    var created: Date
    
    enum CodingKeys: String, CodingKey {
        case id, created
        case originId = "origin_id"
        case instrumentId = "instrument_id"
        case transedUrl = "transed_url"
    }
    
    // 手动实现一个init
    init(id: Int, originId: Int, instrumentId: Int, transedUrl: String,created: Date) {
        self.id = id
        self.originId=originId
        self.instrumentId=instrumentId
        self.transedUrl=transedUrl
        self.created=created
    }
    
    // 解码实现一个init
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        originId = try container.decode(Int.self, forKey: .originId)
        instrumentId = try container.decode(Int.self, forKey: .instrumentId)
        transedUrl = try container.decode(String.self, forKey: .transedUrl)
        let createdAtString = try container.decode(String.self, forKey: .created)
        created = dateFormatter.date(from: createdAtString) ?? Date()
    }
}

struct CollectionList: Codable {
    var code: Int
    var data: [Collection]
    var msg:String
}


var sampleCollection:[Collection]=[
    Collection(id: 1, originId: 14, instrumentId: 1, transedUrl: "", created: sampledate)
]
