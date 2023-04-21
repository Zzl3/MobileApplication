//
//  UserInfo.swift
//  Music
//
//  Created by sihhd on 2023/4/20.
//

import Foundation

struct UserInfo: Codable {
    let code: Int
    let msg: String
    let data: User?
}

struct User: Codable {
    var id: Int
    var mail: String
    var username: String
    var avatar: String
    var created: String
}
