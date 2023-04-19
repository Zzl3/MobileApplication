//
//  Collection.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/18.
//

import SwiftUI
import Foundation

struct Collection: Codable,Identifiable {
    
    let id: Int
    let originId: Int
    let instrumentId: Int
    let transedUrl: String
    let created: Date
    let origin: Origin
    let instrument: InstrumentCollect

    private enum CodingKeys: String, CodingKey {
        case id
        case originId = "origin_id"
        case instrumentId = "instrument_id"
        case transedUrl = "transed_url"
        case created
        case origin
        case instrument
    }
    
    struct Origin: Codable {
        let id: Int
        let name: String
        let artist: String
        let genre: String
        let description: String
        let fileUrl: String
        let createdAt: Date
        let image: String

        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case artist
            case genre
            case description
            case fileUrl = "file_url"
            case createdAt = "created_at"
            case image
        }
    }
    
    struct InstrumentCollect: Codable {
        let id: Int
        let name: String
        let nameImage: String
        let image: String
        let audio: String
        let model: String
        let description: String
        let category: String

        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case nameImage = "name_image"
            case image
            case audio
            case model
            case description
            case category
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(originId, forKey: .originId)
        try container.encode(instrumentId, forKey: .instrumentId)
        try container.encode(transedUrl, forKey: .transedUrl)
        try container.encode(created, forKey: .created)
        try container.encode(origin, forKey: .origin)
        try container.encode(instrument, forKey: .instrument)
    }
}

struct CollectionList: Codable {
    var code: Int
    var data: [Collection]
    var msg: String
}


struct Collection2:Identifiable{
    var id=UUID().uuidString
    var originId: Int
    var instrumentId: Int
    var transedUrl: String
    var created: String
    let origin: Song
    let instrument: Instrument
}

