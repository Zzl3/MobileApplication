//
//  MusicApp.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI
@main
struct MusicApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                Introduction()
                    .tabItem{Label("乐曲介绍",systemImage:"music.note.list")}
                StyleTransfer()
                    .tabItem{Label("风格迁移",systemImage: "music.note.house")}
                MySetting()
                    .tabItem{Label("我的设置",systemImage: "person.circle")}
            }
        }
    }
}
