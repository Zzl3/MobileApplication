//
//  History.swift
//  Music
//
//  Created by sihhd on 2023/4/10.
//

import Foundation
import SwiftUI


struct HistoryView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var sampleHistorys:[History]=[
        History(song: Song(id:1,name: "梅花三弄", artist: "晋朝桓伊", genre: "古曲", description: "《梅花三弄》，又名《梅花引》、《梅花曲》、《玉妃引》，根据《太音补遗》和《蕉庵琴谱》所载，相传原本是晋朝桓伊所作的一首笛曲，后来改编为古琴曲。琴曲的乐谱最早见于公元1425年的《神奇秘谱》。《梅花三弄》全曲共分十段，两大部分，第一部分，前六段，采用循环再现手法，后四段为第二部分，描写梅花静与动两种形象。乐曲通过梅花的洁白芬芳和耐寒等特征，借物抒怀，来歌颂具有高尚节操的人。", fileURL:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/d152aa71e5dd4e4d9411917df42c143f/梅花三弄片段.MP3", createdAt: Date(), image: "history1"), time: "2023-4-10", album: Album(id:1,albumName: "古筝", albumImage: "Instru_guzheng",introduction:"古筝简单介绍")),
        History(song: Song(id:2,name: "百鸟朝凤", artist: "魏子猷", genre: "纯音乐，唢呐独奏", description: "《百鸟朝凤》外文名为《Hundreds Of Birds Worshipping The Phoenix》，是由民乐大师魏子猷原创，流行于河南、安徽、山东、河北等的民族乐曲。其前身是豫剧抬花轿中的伴奏曲，因为豫剧流行很广，使百鸟朝凤流行于河南、山东、河北、安徽等地，又名《百鸟音》，这是一首充分展示唢呐艺术魅力的优秀乐曲。", fileURL:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/777bcd949c9b412e8731e2b5836ee314/百鸟朝凤片段.MP3", createdAt: Date(), image: "history2"), time: "2023-4-9", album: Album(id:2,albumName: "笙", albumImage: "Instru_sheng",introduction:"笙简单介绍")),
        History(song: Song(id:3,name: "牛斗虎片段", artist: "民调", genre: "民调", description: "牛斗虎是一种模拟动物形体、习性的传统民间舞蹈。流传于盂县一带。相传这种舞蹈是根据当地流传的一则民间传说而起源。牛斗虎以牛虎争斗为内容，形象地刻画了老虎的凶猛威武，又颂扬了老牛忠厚倔强。", fileURL:"https://musicstyle.oss-cn-shanghai.aliyuncs.com/files/e8c4abd9027a4f9aa4339ca5ea69ff17/牛斗虎片段.MP3", createdAt: Date(), image: "history3"), time: "2023-4-8", album: Album(id:2,albumName: "笙", albumImage: "Instru_sheng",introduction:"笙简单介绍"))
    ]
//    @State var sampleHistorys=UserDefaults.standard.object(forKey: "history") as? [History]
    
    var body: some View {
        
        
        VStack {
//            HStack {
//                Text("历史记录")
//                .font(.system(size: 35))
//                .fontWeight(.heavy)
//                .padding()
//                Spacer()
//            }
//            .background(Color(""))
                
            
            NavigationView {
                List {
                    ForEach(sampleHistorys) { history in
    //                    DetailView(animation: animation, album: selectedInstru, song: song, show: $showDetail)
                        NavigationLink(destination:TestView()){
                            HStack {
                                Image(history.song.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .background(Color.black)
                                    .cornerRadius(20)
                                    .padding(.trailing, 4)
                                
                                VStack(alignment: .leading, spacing: 8.0) {
                                    HStack{
                                        Text(history.song.name)
                                            .font(.system(size: 20, weight: .bold))
                                        
                                        Text(history.song.artist)
                                            .font(.system(size: 20, weight: .bold))
                                    }
                                    
                                    HStack{
                                        Image(history.album.albumImage)
                                            .resizable()
                                            .frame(width: 30,height: 30)
                                            .aspectRatio(contentMode: .fit)
                                            .rotationEffect(.init(degrees: -2))
                                        
                                        Text(history.album.albumName)
                                            .lineLimit(2)
                                            .font(.subheadline)
                                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                        
                                    }
                                                                    
                                    Text(history.time)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .onDelete { index in
                        self.sampleHistorys.remove(at: index.first!)
                    }
                    .onMove { (source: IndexSet, destination: Int) in
                        self.sampleHistorys.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .navigationBarItems(trailing: EditButton().font(.title2).foregroundColor(Color.primary))
                .navigationBarTitle(Text("历史记录"))
                
            }
        }
        .background(Color.white)
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(AppSettings())
    }
}

