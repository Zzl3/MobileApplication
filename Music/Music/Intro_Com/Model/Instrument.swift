//
//  Instrument.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/9.
//

import SwiftUI
import Foundation

struct Instrument: Codable, Identifiable  {
    let id: Int
    let name: String
    let nameImage: String
    let image: String
    let model: String
    let description: String
    let category: String
       
    enum CodingKeys: String, CodingKey {
        case id, name, image, model, description, category
        case nameImage = "name_image"
    }
}

var sampleInstrument:[Instrument]=[
    Instrument(id:0,name: "笙",nameImage:"ShengT",image:"ShengP",model: "**",description: "笙",category: "打击乐器")
]

struct InstrumentList: Codable {
    let code: Int
    let msg: Int
    let data: [Instrument]
}
