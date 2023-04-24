//
//  FileData.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/24.
//

import Foundation

struct ImageList: Codable {
    let code: Int
    let msg: String
    let data:[ImageData]
}

struct ImageData: Codable {
    var file: String
    var url: String
    var success: Bool
}
