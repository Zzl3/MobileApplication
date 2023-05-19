//
//  CollectionView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct CollectionView: View {
    @EnvironmentObject var appSettings: AppSettings
   // @State var collectionList: CollectionList?
    @State var sampleCollection = [
        Collection2(
            originId: 2,
            instrumentId: 3,
            transedUrl:  "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",
            created: "2023-3-20",
            origin: Song(
                id: 2,
                name: "百鸟朝凤",
                artist: "魏子猷",
                genre: "纯音乐，唢呐独奏",
                description: "《百鸟朝凤》外文名为《Hundreds Of Birds Worshipping The Phoenix》，是由民乐大师魏子猷原创，流行于河南、安徽、山东、河北等的民族乐曲。其前身是豫剧抬花轿中的伴奏曲，因为豫剧流行很广，使百鸟朝凤流行于河南、山东、河北、安徽等地，又名《百鸟音》，这是一首充分展示唢呐艺术魅力的优秀乐曲。",
                fileURL:  "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",
                createdAt: Date(),
                image: "https://s2.loli.net/2023/04/10/ewD2kGJUxVcipNX.png"
            ),
            instrument: Instrument(
                id: 3,
                name: "笛子",
                nameImage:  "https://s2.loli.net/2023/04/09/NFIv6MAl93PYea8.png",
                image:  "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/9759f6d1f08a4d23bfe6ee99267d1007/成品效果图无背景.png",
                audio: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",
                model: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/0eaa347cb0034b7990636c8d9d6a3efa/di.usdz",
                description: " 笛子是迄今为止发现的最古老的汉族乐器，也是汉族乐器中最具代表性最有民族特色的吹奏乐器。中国传统音乐中常用的横吹木管乐器之一，中国竹笛，一般分为南方的曲笛、北方的梆笛和介于两者之间的中音笛。音域一般能达到两个八度多两个。 笛子常在中国民间音乐、戏曲、中国民族乐团、西洋交响乐团和现代音乐中运用，是中国音乐的代表乐器之一。在民族乐队中，笛子是举足轻重的吹管乐器，被当做民族吹管乐的代表。",
                category: "吹管乐器"
            )
        ),
        Collection2(
            originId: 5,
            instrumentId: 6,
            transedUrl:  "https://example.com/transed2",
            created: "2023-4-16",
            origin: Song(
                id: 5,
                name: "梅花三弄",
                artist: "晋朝桓伊",
                genre: "古曲",
                description: "《梅花三弄》，又名《梅花引》、《梅花曲》、《玉妃引》，根据《太音补遗》和《蕉庵琴谱》所载，相传原本是晋朝桓伊所作的一首笛曲，后来改编为古琴曲。琴曲的乐谱最早见于公元1425年的《神奇秘谱》。《梅花三弄》全曲共分十段，两大部分，第一部分，前六段，采用循环再现手法，后四段为第二部分，描写梅花静与动两种形象。乐曲通过梅花的洁白芬芳和耐寒等特征，借物抒怀，来歌颂具有高尚节操的人。",
                fileURL: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/d152aa71e5dd4e4d9411917df42c143f/梅花三弄片段.MP3",
                createdAt: Date(),
                image:  "https://s2.loli.net/2023/04/10/CWsZX8DfKUh7uAN.png"
            ),
            instrument: Instrument(
                id: 6,
                name: "笛子",
                nameImage: "https://s2.loli.net/2023/04/09/ZLrBwuXSPHYoi2j.png",
                image: "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/9759f6d1f08a4d23bfe6ee99267d1007/成品效果图无背景.png",
                audio:  "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3",
                model:  "https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/f6ce164b03a74b1f8978654713269f91/model.obj",
                description: "唢呐，中国传统双簧木管乐器。早在公元3世纪，唢呐随丝绸之路的开辟，从东欧、西亚一带传入我国，是世界双簧管乐器家族中的一员，经过几千年的发展，使唢呐拥有其独特的气质与音色，已是我国具有代表性的民族管乐器。",
                category: "吹管乐器"
            )
        )
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(sampleCollection) { collect in
                        NavigationLink(destination:TestView()){
                            HStack {
                                Image(uiImage: UIImage.fetchImage(from: collect.origin.image))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .background(Color.black)
                                    .cornerRadius(20)
                                    .padding(.trailing, 4)

                                VStack(alignment: .leading, spacing: 8.0) {
                                    HStack{
                                        Text(collect.origin.name)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)

                                        Text(collect.origin.artist)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                    HStack{
                                        Image(uiImage: UIImage.fetchImage(from: collect.instrument.image))
                                            .resizable()
                                            .frame(width: 30,height: 30)
                                            .aspectRatio(contentMode: .fit)
                                            .rotationEffect(.init(degrees: -2))

                                        Text(collect.instrument.name)
                                            .lineLimit(2)
                                            .font(.subheadline)
                                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))

                                    }
                                    Text(collect.created)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .onDelete { index in
                        sampleCollection.remove(at: index.first!)
                    }
                    .onMove { (source: IndexSet, destination: Int) in
                        sampleCollection.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .navigationBarItems(trailing: EditButton().font(.title2).foregroundColor(Color.primary))
                .navigationBarTitle(Text("我的收藏"))
                }
        }
        .background(Color.white)
        //.onAppear {fetchData()}
    }
    
//    func fetchData() {
//        // 得到所有的收藏id
//        var userid=1
//        let urlString = "http://123.60.156.14:5000/my_loves?user_id=\(userid)"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        print(url)
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//               print("Error: \(error.localizedDescription)")
//               return
//           }
//
//           if let httpResponse = response as? HTTPURLResponse {
//               print("Status code: \(httpResponse.statusCode)")
//               if httpResponse.statusCode != 200 {
//                   print("Server returned error")
//                   return
//               }
//           }
//
//            if let data = data {
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    //print("JSON: \(json)")
//                }
//
//                do {
//                    let decoder = JSONDecoder()
//                    let collectionList = try decoder.decode(CollectionList.self, from: data)
//                    DispatchQueue.main.async {
//                        self.collectionList = collectionList
//                        print(collectionList)
//                    }
//                } catch {
//                    print("Error decoding data: \(error.localizedDescription)")
//                }
//            }
//        }.resume()
//    }

//    func getSong(songid: Int, completion: @escaping (Song?) -> Void) {
//        let urlString = "http://123.60.156.14:5000/music_id?id=\(songid)"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//                if let songDe = try? decoder.decode(SongDe.self, from: data) {
//                    let song = songDe.data
//                    completion(song)
//                } else {
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }.resume()
//    }

//    func getInstrument(instruid: Int, completion: @escaping (Instrument?) -> Void) {
//        let urlString = "http://123.60.156.14:5000/instrument?id=\(instruid)"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//                if let instruDe = try? decoder.decode(InstrumentDe.self, from: data) {
//                    let instrument = instruDe.data
//                    completion(instrument)
//                } else {
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }.resume()
//    }
}



struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView().environmentObject(AppSettings())
    }
}
