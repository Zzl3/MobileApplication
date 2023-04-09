//
//  Song.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//
import SwiftUI
import Foundation

struct Song:Identifiable,Hashable,Codable {
    var id=UUID().uuidString
    var name:String
    var songImage:String
    var artist:String
    var description:String
    var file_url:String
}

var sampleSong:[Song]=[
    Song(name: "summer", songImage: "testpic",artist:"久石让",description: "Summer",file_url: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3")
]

class MyData: ObservableObject {
    @Published var dataArray = [Song]() //接收数据的数组
    init(){
        guard let url = URL(string: "http://123.60.156.14:5000/music_all") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                // 将返回的数据解码
                let decodedResponse = try JSONDecoder().decode([Song].self, from: data)
                DispatchQueue.main.async {
                    self.dataArray = decodedResponse //赋值给dataArray这个数组
                    print(self.dataArray)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
