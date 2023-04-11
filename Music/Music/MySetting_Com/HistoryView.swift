//
//  History.swift
//  Music
//
//  Created by sihhd on 2023/4/10.
//

import Foundation
import SwiftUI


struct HistoryView: View {
    @Binding var showHistory : Bool
    
    @State var sampleHistorys:[History]=[
        History(song: Song(id:1,name: "testName", artist: "testArtist", genre: "testGenre", description: "test", fileURL:"", createdAt: Date(), image: "testpic"), time: "2023-4-10", album: Album(albumName: "古筝", albumImage: "Instru_guzheng",introduction:"古筝简单介绍")),
        History(song: Song(id:2,name: "testName1", artist: "testArtist1", genre: "testGenre1", description: "test1", fileURL:"", createdAt: Date(), image: "testpic"), time: "2023-4-9", album: Album(albumName: "笙", albumImage: "Instru_sheng",introduction:"笙简单介绍"))
    ]
    
    var body: some View {
        
//        HStack{
//            Button{
//                withAnimation(.easeInOut(duration: 0.35)){
//                    showHistory=false
//                }
//            } label: {
//                Label("返回",systemImage: "arrow.left")
//                    .font(.title2)
//                    .foregroundColor(.black)
//                    .padding(15)
//            }
//            .frame(maxWidth: .infinity,alignment: .leading)
//        }
//        .padding()
        
//        NavigationLink{
//            MySetting()
//        }label: {
//            Label("返回",systemImage: "arrow.left")
//                .font(.title2)
//                .foregroundColor(.black)
//                .padding(15)
//        }
//        .frame(maxWidth: .infinity,alignment: .leading)
        
        Button{
            withAnimation(.easeInOut(duration: 0.35)){
                showHistory=false
            }
        } label: {
            Label("返回",systemImage: "arrowshape.turn.up.backward")
                .font(.title2)
                .foregroundColor(.black)
                .padding(15)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        
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
            .navigationBarTitle(Text("历史记录"))
            .navigationBarItems(trailing: EditButton().font(.title2).foregroundColor(Color.black))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(showHistory: .constant(false))
    }
}

