//
//  SongInstru.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/17.
//

import SwiftUI

struct MyResponse: Codable {
    let code: Int
    let data: MyData
    let msg: String
}

struct MyData: Codable {
    let id: Int
    let origin_id: Int
    let instrument_id: Int
    let transed_url: String
}
