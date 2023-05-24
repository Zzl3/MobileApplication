//
//  Post.swift
//  Music
//
//  Created by 周紫蕾 on 2023/5/23.
//

import SwiftUI

struct Post: Identifiable {
    
    var id = UUID().uuidString
    var postImg: String
    var titile: String
    var description: String
    var starRating: Int
    var scene: String
}

var posts = [
    Post(postImg: "p1", titile: "古筝", description: "古筝，弹拨弦鸣乐器，又名汉筝、秦筝，是汉民族古老的民族乐器。", starRating: 4,scene: "1.scn"),
    Post(postImg: "p9", titile: "陀螺圆鼓", description: "圆鼓，朝鲜族打击乐器，外形呈扁圆形，故有扁鼓之称。", starRating: 3,scene: "1.scn"),
    Post(postImg: "p12", titile: "编钟", description: "编钟是中国古代的一种打击乐器，用青铜铸成，能发出不同的乐音。", starRating: 5,scene: "2.scn"),
    Post(postImg: "p34", titile: "班卓琴", description: "班卓琴，又称斑鸠琴或五弦琴，是美国的非洲裔奴隶由几种非洲乐器发展而成。", starRating: 3,scene: "1.scn"),
    
    Post(postImg: "p13", titile: "木鼓", description: "木鼓是佤族等少数民族人民使用的民间乐器，已在我国今台湾省流行。", starRating: 2,scene: "1.scn"),
    
    Post(postImg: "p15", titile: "三弦琴", description: "三弦琴，又称三弦，是中国的弹拨乐器。", starRating: 5,scene: "1.scn"),
    
    Post(postImg: "p21", titile: "牛皮鼓", description: "牛皮鼓，又称堂鼓、喜庆鼓，多用于江南祠堂内婚嫁迎娶和迎新年等。", starRating: 4,scene: "1.scn")
    
]
