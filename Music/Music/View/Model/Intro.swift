//
//  Intro.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/17.
//

import SwiftUI

struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var introduction: String
}

var intros: [Intro] = [
    .init(imageName: "image1", title: "独特的音乐体验",introduction: "将不同古典乐器演奏的音乐风格进行转换，体验古乐之间的奇妙变幻，让你在音乐中穿越千年古韵。"),
    .init(imageName: "image2", title: "古典乐器介绍",introduction: "包含着详细而精致的中国古典乐器介绍，以辅助各位音乐爱好者更好地认知和欣赏那古老而典雅的音乐艺术。"),
    .init(imageName: "image3", title: "创新实践",introduction: "结合了机器学习和人工智能技术，充分展示了现代科技在古典音乐领域中的创新实践，彰显了文化传承与技术创新的有机结合。")
]


let sansBold = "WorkSans-Bold"
let sansSemiBold = "WorkSans-SemiBold"
let sansRegular = "WorkSans-Regular"

let dummyText = "此应用程序以语音风格迁移为核心，能够为用户展示多种中国古典乐器，实现不同乐器之间音乐的风格迁移。只需一键操作，便能欣赏到惊喜不断的古典音乐之旅！"
