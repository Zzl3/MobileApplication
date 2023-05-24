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
}

var posts = [
    Post(postImg: "p1", titile: "古筝", description: "古筝，弹拨弦鸣乐器，又名汉筝、秦筝，是汉民族古老的民族乐器，流行于中国各地。经过千百年的发展，主要形成了客家筝、潮州筝、山东筝、河南筝四大流派。", starRating: 4),
    Post(postImg: "p9", titile: "陀螺圆鼓", description: "圆鼓，朝鲜族打击乐器，外形呈扁圆形，故有扁鼓之称。鼓面直径30厘米～45厘米、鼓框高15厘米～20厘米，鼓框涂以红漆，描绘金色花卉图案，并使用红色线绳勒紧鼓皮。", starRating: 3),
    Post(postImg: "p12", titile: "编钟", description: "编钟是中国古代的一种打击乐器，用青铜铸成，它由大小不同的扁圆钟按照音调高低的次序排列起来，悬挂在一个巨大的钟架上，用丁字形的木锤和长形的棒分别敲打铜钟，能发出不同的乐音。", starRating: 5),
    Post(postImg: "p34", titile: "班卓琴", description: "班卓琴（英语：banjo），又称斑鸠琴或五弦琴，是美国的非洲裔奴隶由几种非洲乐器发展而成，主流的班卓琴为5根弦（四长一短），另外还有用于弹奏爵士乐是4弦拨片班卓琴和用于弹奏爱尔兰音乐的四弦高音班卓琴。6弦的通常被称作班卓吉他，弹奏方法和吉他一样。", starRating: 3),
    
    Post(postImg: "p13", titile: "木鼓", description: "木鼓是佤族等少数民族人民使用的民间乐器，佤语称库洛、克拉。历史久远，形制古朴，发音低沉，应用广泛。1700多年前，已在我国今台湾省流行。", starRating: 2),
    
    Post(postImg: "p15", titile: "三弦琴", description: "三弦琴，又称三弦，是中国的弹拨乐器。其名最早出现于明杨慎《升庵外集》：“今次三弦，始于元时。”而清毛其龄《西河词话》：“三弦起于秦时，本三十鼓鼓之制而改形易响，谓之鼓鼓，唐时乐人多习之，世以为胡乐，非也。”", starRating: 5),
    
    Post(postImg: "p21", titile: "牛皮鼓", description: "牛皮鼓，又称堂鼓、喜庆鼓，多用于江南祠堂内婚嫁迎娶和迎新年等。牛皮鼓的制作工艺考究，有数十道工序，包括处理牛皮、刨制鼓腔、蒙皮、拉皮、钉钉，每道工序都考验着手艺人的技艺和耐心。", starRating: 4)
    
]
