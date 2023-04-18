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
    let audio: String?
    let model: String
    let description: String
    let category: String
       
    enum CodingKeys: String, CodingKey {
        case id, name, image, model, description, category, audio
        case nameImage = "name_image"
    }
}

var sampleInstrument:[Instrument]=[
    Instrument(id:8,name: "笛子",nameImage:"https://s2.loli.net/2023/04/09/NFIv6MAl93PYea8.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/9759f6d1f08a4d23bfe6ee99267d1007/成品效果图无背景.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/0eaa347cb0034b7990636c8d9d6a3efa/di.usdz",description: " 笛子是迄今为止发现的最古老的汉族乐器，也是汉族乐器中最具代表性最有民族特色的吹奏乐器。中国传统音乐中常用的横吹木管乐器之一，中国竹笛，一般分为南方的曲笛、北方的梆笛和介于两者之间的中音笛。音域一般能达到两个八度多两个。 笛子常在中国民间音乐、戏曲、中国民族乐团、西洋交响乐团和现代音乐中运用，是中国音乐的代表乐器之一。在民族乐队中，笛子是举足轻重的吹管乐器，被当做民族吹管乐的代表。",category: "吹管乐器"),
    Instrument(id:9,name: "唢呐",nameImage:"https://s2.loli.net/2023/04/09/ZLrBwuXSPHYoi2j.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/c275530253e44babbc866c76cace4e23/image.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/f6ce164b03a74b1f8978654713269f91/model.obj",description: "唢呐，中国传统双簧木管乐器。早在公元3世纪，唢呐随丝绸之路的开辟，从东欧、西亚一带传入我国，是世界双簧管乐器家族中的一员，经过几千年的发展，使唢呐拥有其独特的气质与音色，已是我国具有代表性的民族管乐器。",category: "吹管乐器"),
    Instrument(id:10,name: "箫",nameImage:"https://s2.loli.net/2023/04/09/d2fwSjWXNihFIlu.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/ac29ada969bb4fd2a5426e3cc0d11f9b/image.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/d152aa71e5dd4e4d9411917df42c143f/梅花三弄片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/40c7d21fdd454d98bfae9f69857e6e79/model.usdz",description: "箫，分为洞箫和琴箫，皆为单管、竖吹，是一种非常古老的汉族吹奏乐器。音色圆润轻柔，幽静典雅，适于独奏和重奏。",category: "吹管乐器"),
    Instrument(id:11,name: "编钟",nameImage:"https://s2.loli.net/2023/04/09/OgzEmAKV1Srfyv5.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/f1d98f80c31f4ea886cd77495ced6d89/image.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/283385e4d1494b2eb0c5722d826cb9f9/茉莉花片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/15c4a2b6e34d44779bf71dc48df082a6/编钟_01.obj",description: "编钟是中国汉民族古代重要的打击乐器，是钟的一种。编钟兴起于周朝，盛于春秋战国直至秦汉。编钟由若干个大小不同的钟有次序地悬挂在木架上编成一组或几组，每个钟敲击的音高各不相同。由于年代不同，编钟的形状也不尽相同，但钟身都绘有精美的图案。",category: "打击乐器"),
    Instrument(id:12,name: "大鼓",nameImage:"https://s2.loli.net/2023/04/09/yb4PDUYKQHk9Jvr.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/c89fa1c9bde941728657bd5b34391c7a/image.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/e8c4abd9027a4f9aa4339ca5ea69ff17/牛斗虎片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/8da42d7a612c42eeac5553ab65de978a/Drum.obj",description: "鼓是我国传统的打击乐器，按《礼记·明堂位》的记载，在很早的传说中，“伊耆氏”之时就已有“土鼓”，即陶土作成的鼓。由于鼓有良好的共鸣作用，声音激越雄壮而传声很远，所以很早就被华夏祖先作为军队上助威之用。",category: "打击乐器"),
    Instrument(id:13,name: "古筝",nameImage:"https://s2.loli.net/2023/04/09/L6t3e9NayFzrwZM.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/1a83c8881f3c4ccf895c924268432aca/image.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/318cdfb8b79841ada3fea6adb6ab83fd/高山流水片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/ee2bb6c6381d4b679407076068272d32/model.obj",description: "古筝，弹拨弦鸣乐器，又名汉筝、秦筝，是汉民族古老的民族乐器，流行于中国各地。常用于独奏、重奏、器乐合奏和歌舞、戏曲、曲艺的伴奏。",category: "弹拨乐器"),
    Instrument(id:14,name: "琵琶",nameImage:"https://s2.loli.net/2023/04/09/A7Uix95JPjHKGYZ.png",image:"https://s2.loli.net/2023/04/10/XdwN2UyzE94kvbQ.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/79868c4362d04adabdb7f39b78f91a2e/十面埋伏片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/5bd36aa4b9b44d7b9d65b1ac4cc410bb/model.obj",description: "琵琶，弹拨乐器首座， 拨弦类弦鸣乐器。木制或竹等制成，音箱呈半梨形，上装四弦，原先是用丝线，现多用钢丝、钢绳、尼龙制成。颈与面板上设有以确定音位的“相”和“品”。",category: "弹拨乐器"),
    Instrument(id:15,name: "中阮",nameImage:"https://s2.loli.net/2023/04/09/fWds7RXYSFjBxMc.png",image:"https://s2.loli.net/2023/04/10/h1LMigGTWp6yadV.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/65daf30d0753497485a786c4be07c748/钟南古韵片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/e0eadd6c37294be885a7d06307d1a556/古代乐器_阮乐器_爱给网_aigei_com.zip",description: "中阮是中国具有悠久历史的民族弹拨乐器，中华民族传统弹拨乐器，是古琵琶的一种，已有两千年的历史。阮是阮咸，“阮咸琵琶”的简称。阮由汉代琵琶衍变而来，其历史悠久，音响富于特色。",category: "弹拨乐器"),
    Instrument(id:16,name: "二胡",nameImage:"https://s2.loli.net/2023/04/09/NMEfwPbu4aFqG9c.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/6a318bdd3f034c0bac5bb6295792fdd4/image.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/f6e040e23e504e9091a64199b233f889/二泉映月片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/6b6fa1baff094498b07eede3d518aab2/二胡_爱给网_aigei_com.rar",description: "二胡（拼音：Erhu） 始于唐朝，称奚琴，已有一千多年的历史。是一种中国传统拉弦乐器。二胡，即二弦胡琴，又名南胡、嗡子，二胡是中华民族乐器家族中主要的弓弦乐器（擦弦乐器）之一。二胡音色近乎跟人声一样，具有歌唱性、诉说感。二胡名曲有《二泉映月》《良宵》《听松》《赛马》《葡萄熟了》等。",category: "拉弦乐器"),
    Instrument(id:17,name: "京胡",nameImage:"https://s2.loli.net/2023/04/09/pLYsHMftEU3OkuN.png",image:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/d6ebd7e6361541038fea9ff83b60fcef/image.png",audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/c60a858d52e74dee811ded6454c91c40/夜深沉片段.MP3",model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/0000c30623d943a1a48ba69733f0aeb0/",description: " 京胡，又称胡琴。是中国的传统拉弦乐器。18世纪时末期，随着中国传统戏曲京剧的形成，在拉弦乐器胡琴的基础上改制而成，已有200多年的历史，是中国传统戏曲京剧的主要伴奏乐器。 早期的京胡只有一种规格，经过制琴师与演奏者长期的实践，京胡发展为各种规格，以适应京剧音乐发展的需要。如今，中国的作曲家还为京胡创作了很多独奏、协奏曲，京胡也从为京剧伴奏的角落走到了舞台的中央。",category: "拉弦乐器")
]

struct InstrumentList: Codable {
    let code: Int
    let msg: Int
    let data: [Instrument]
}

struct InstrumentDe: Codable {
    let code: Int
    let msg: String
    let data: Instrument
}
