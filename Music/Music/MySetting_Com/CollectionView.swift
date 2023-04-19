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
    @State var collectionList: CollectionList?
    
    var body: some View {
        VStack {
            NavigationView {
                List {
//                    ForEach(collectionList!.data) { collect in
//                        var song:Song? // 得到歌曲
//                        var instrument:Instrument? //得到乐器
//                        
//                        song=getSong(songid: collect.originId) //报错
//                        instrument=getInstrument(instruid: collect.instrumentId) //报错
//                        
//                        NavigationLink(destination:TestView()){
//                            HStack {
//                                Image(uiImage: UIImage.fetchImage(from: song.image))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 80, height: 80)
//                                    .background(Color.black)
//                                    .cornerRadius(20)
//                                    .padding(.trailing, 4)
//                                
//                                VStack(alignment: .leading, spacing: 8.0) {
//                                    HStack{
//                                        Text(song.name)
//                                            .font(.system(size: 20, weight: .bold))
//                                        
//                                        Text(song.artist)
//                                            .font(.system(size: 20, weight: .bold))
//                                    }
//                                    HStack{
//                                        Image(uiImage: UIImage.fetchImage(from: instrument.image))
//                                            .resizable()
//                                            .frame(width: 30,height: 30)
//                                            .aspectRatio(contentMode: .fit)
//                                            .rotationEffect(.init(degrees: -2))
//                                        
//                                        Text(instrument?.name)
//                                            .lineLimit(2)
//                                            .font(.subheadline)
//                                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
//                                        
//                                    }
//                                    Text(collect.created)
//                                        .font(.caption)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                            .padding(.vertical, 8)
//                        }
//                    }
//                    .onDelete { index in
//                        sampleCollection.remove(at: index.first!)
//                    }
//                    .onMove { (source: IndexSet, destination: Int) in
//                        sampleCollection.move(fromOffsets: source, toOffset: destination)
//                    }
                }
                .navigationBarItems(trailing: EditButton().font(.title2).foregroundColor(Color.primary))
                .navigationBarTitle(Text("我的收藏"))
                }
        }
        .background(Color.white)
        .onAppear {fetchData()}
    }
    
    func fetchData() {
        // 得到所有的收藏id
        var userid=1
        let urlString = "http://123.60.156.14:5000/my_loves?user_id=\(userid)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let collectionList = try? decoder.decode(CollectionList.self, from: data) {
                    DispatchQueue.main.async {
                        self.collectionList = collectionList
                    }
                }
            }
        }.resume()
    }
    
    func getSong(songid: Int, completion: @escaping (Song?) -> Void) {
        let urlString = "http://123.60.156.14:5000/music_id?id=\(songid)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let songDe = try? decoder.decode(SongDe.self, from: data) {
                    let song = songDe.data
                    completion(song)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }

    func getInstrument(instruid: Int, completion: @escaping (Instrument?) -> Void) {
        let urlString = "http://123.60.156.14:5000/instrument?id=\(instruid)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let instruDe = try? decoder.decode(InstrumentDe.self, from: data) {
                    let instrument = instruDe.data
                    completion(instrument)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}



struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView().environmentObject(AppSettings())
    }
}
