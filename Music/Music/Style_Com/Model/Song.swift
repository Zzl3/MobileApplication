//
//  Song.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//
import SwiftUI
import Foundation

import SwiftUI

struct Song: Codable,Identifiable {
    var id: Int
    var name: String
    var artist: String
    var genre: String
    var description: String
    var fileURL: String?
    var createdAt: Date
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, artist, genre, description,image
        case fileURL = "file_url"
        case createdAt = "created_at"
    }
    
    // 手动实现一个init
    init(id: Int, name: String, artist: String, genre: String, description: String, fileURL: String, createdAt: Date,image: String) {
            self.id = id
            self.name = name
            self.artist = artist
            self.genre = genre
            self.description = description
            self.fileURL = fileURL
            self.createdAt = createdAt
            self.image = image
    }
    
    // 解码实现一个init
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        genre = try container.decode(String.self, forKey: .genre)
        description = try container.decode(String.self, forKey: .description)
        fileURL = try container.decode(String.self, forKey: .fileURL)
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        createdAt = dateFormatter.date(from: createdAtString) ?? Date()
        image = try container.decode(String.self, forKey: .image)
    }
}

struct SongList: Codable {
    var code: Int
    var data: [Song]
}

struct SongDe: Codable {
    var code: Int
    var msg: String
    var data: Song
}

let dateComponents = DateComponents(year: 2023, month: 4, day: 10, hour: 15, minute: 0, second: 0)
let calendar = Calendar.current
let sampledate = calendar.date(from: dateComponents)!

var sampleSong:[Song]=[
    Song(id: 14,
         name: "百鸟朝凤",
         artist:"魏子猷",
         genre: "纯音乐，唢呐独奏",
         description: "《百鸟朝凤》外文名为《Hundreds Of Birds Worshipping The Phoenix》，是由民乐大师魏子猷原创，流行于河南、安徽、山东、河北等的民族乐曲。其前身是豫剧抬花轿中的伴奏曲，因为豫剧流行很广，使百鸟朝凤流行于河南、山东、河北、安徽等地，又名《百鸟音》，这是一首充分展示唢呐艺术魅力的优秀乐曲。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/ewD2kGJUxVcipNX.png"),
    Song(id: 15,
         name: "梅花三弄",
         artist:"晋朝桓伊",
         genre: "古曲",
         description: "《梅花三弄》，又名《梅花引》、《梅花曲》、《玉妃引》，根据《太音补遗》和《蕉庵琴谱》所载，相传原本是晋朝桓伊所作的一首笛曲，后来改编为古琴曲。琴曲的乐谱最早见于公元1425年的《神奇秘谱》。《梅花三弄》全曲共分十段，两大部分，第一部分，前六段，采用循环再现手法，后四段为第二部分，描写梅花静与动两种形象。乐曲通过梅花的洁白芬芳和耐寒等特征，借物抒怀，来歌颂具有高尚节操的人。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/d152aa71e5dd4e4d9411917df42c143f/梅花三弄片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/CWsZX8DfKUh7uAN.png"),
    Song(id: 16,
         name: "茉莉花",
         artist:"何仿(改编)",
         genre: "民调",
         description: "《《茉莉花》由何仿改编自中国民歌《鲜花调》，于1957年首次以单曲形式发行。该曲属于小调类民歌，是单乐段的歌曲。它以五声调式和级进的旋律，表现了委婉流畅、柔和与优美的江南风格，生动刻画了一个文雅贤淑的少女被芬芳美丽的茉莉花所吸引，欲摘不忍，欲弃不舍的爱慕和眷恋之情。全曲婉转精美，感情深厚又含蓄。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/283385e4d1494b2eb0c5722d826cb9f9/茉莉花片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/PUT4wAyERKvWoV9.png"),
    Song(id: 17,
         name: "牛斗虎片段",
         artist:"民调",
         genre: "民调",
         description: "牛斗虎是一种模拟动物形体、习性的传统民间舞蹈。流传于盂县一带。相传这种舞蹈是根据当地流传的一则民间传说而起源。牛斗虎以牛虎争斗为内容，形象地刻画了老虎的凶猛威武，又颂扬了老牛忠厚倔强。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/e8c4abd9027a4f9aa4339ca5ea69ff17/牛斗虎片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/OCpM15NcAstmul7.png"),
    Song(id: 18,
         name: "高山流水",
         artist:"(先秦)伯牙",
         genre: "纯音乐",
         description: "《高山流水》，中国古琴曲，属于中国十大古曲之一。相传先秦的琴师伯牙一次于山野间弹琴，樵夫钟子期竟能领会这是描绘“峨峨兮若泰山”和“洋洋兮若江河”。伯牙惊道：“善哉，子之心而与吾心同。”钟子期死后，伯牙痛失知音，摔琴绝弦，终生不弹，故有高山流水之曲。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/318cdfb8b79841ada3fea6adb6ab83fd/高山流水片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/8bnBdThCaHrXPeA.png"),
    Song(id: 19,
         name: "十面埋伏",
         artist:"汤应曾",
         genre: "琵琶独奏",
         description: "《十面埋伏》，又名《淮阴平楚》，是以楚汉相争的历史为题材而创作的琵琶独奏曲。乐曲整体可分为三部分，由十三段带有小标题的段落构成，分别是：列营、吹打、点将、排阵、走队、埋伏、鸡鸣山小战、九里山大战、项王败阵、乌江自刎、众军奏凯、诸将争功和得胜回营。以公元前202年刘邦与项羽垓下之战的史实为内容，用标题音乐的形式描绘了激烈的战争场面。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/79868c4362d04adabdb7f39b78f91a2e/十面埋伏片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/kc4gYNAHtpwTuab.png"),
    Song(id: 20,
         name: "终南古韵",
         artist:"宁勇",
         genre: "中阮独奏",
         description: "中阮独奏曲。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/65daf30d0753497485a786c4be07c748/钟南古韵片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/xhsQLjMJ68teGi2.png"),
    Song(id: 21,
         name: "二泉映月",
         artist:"阿炳",
         genre: "二胡独奏",
         description: "《二泉映月》，是中国民间音乐家华彦钧（阿炳）的代表作。这首乐曲自始至终流露的是一位饱尝人间辛酸和痛苦的盲艺人的思绪情感，作品展示了独特的民间演奏技巧与风格，以及无与伦比的深邃意境，显示了中国二胡艺术的独特魅力，它拓宽了二胡艺术的表现力，曾获“20世纪华人音乐经典作品奖”。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/f6e040e23e504e9091a64199b233f889/二泉映月片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/SLgdMNY4XJkRQOP.png"),
    Song(id: 22,
         name: "夜深沉",
         artist:"无猷",
         genre: "戏曲",
         description: "《夜深沉》是一个京剧曲牌名。曲调由繁至简，在快板段落作了较多发展，其中有大鼓的独奏及鼓与京胡的竞奏，使原曲的精华--刚劲且优美的音乐得到充分优美的表现。在京剧《击鼓骂曹》和《霸王别姬》中，用 它来配合祢衡击鼓和虞姬舞剑等的场面。",
         fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/c60a858d52e74dee811ded6454c91c40/夜深沉片段.MP3",
         createdAt:sampledate,
         image:"https://s2.loli.net/2023/04/10/ifh4dBIR5O2jlYH.png")
    
]
