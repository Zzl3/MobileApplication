//
//  StyleTransfer.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI


struct SongGroup:Identifiable{  //歌曲按乐器分类
    var id=UUID().uuidString
    var instru:String
    var songList:[Song]
    var expanded:Bool=false  //是否展开
}

struct SongCell:View{
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject private var viewmodel:Viewmodel
    let instru:Song
    
    var body: some View {
        VStack(spacing:0){
            HStack(alignment: .top){
                Image(uiImage: UIImage.fetchImage(from: instru.image))
                    .resizable()
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius:25)
                    .stroke(lineWidth: 4))
                    .alignmentGuide(.leading){ _ in 0 }
                    .frame(width: 50,height:50)
                VStack{
                    Text(instru.name)
                        .foregroundColor(.black)
                    
                    Text(instru.artist)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }.padding()
    }
}

struct InstruCell:View{
    @EnvironmentObject private var viewmodel:Viewmodel
    var instru:SongGroup
    @State var height:CGFloat=0
    
    var body:some View{
       content
            .padding(.leading)
            .frame(maxWidth:.infinity)
            .foregroundColor(.black)
    }
    
    private var content:some View{
        VStack(alignment: .leading, spacing:8){
            sectionHeader
            if instru.expanded{
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(0..<instru.songList.count,id:\.self){ index in
                            NavigationLink(destination:SongChoose(song:instru.songList[index])){
                                SongCell(instru:instru.songList[index])
                            }
                        }
                    }.overlay(
                        GeometryReader{ proxy -> Color in
                            DispatchQueue.main.async{
                                height = proxy.size.height
                            }
                            return Color.clear
                        }
                    )
                }
                .padding(.all,0)
                .frame(height:height)
                .animation(.default,value:height)
                .clipped()
            }
        }
    }
    
    private var sectionHeader:some View{
            VStack(spacing:0){
                HStack{
                    Text(instru.instru)
                        .padding(.vertical,10)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName:"chevron.right")
                        .rotationEffect(Angle.init(degrees: instru.expanded ? 90 : 0))
                }.padding(.trailing,10)
                Divider()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation{
                    viewmodel.expand(instru)
                }
            }
        }
    
}

struct ContentView:View{
    @StateObject private var viewmodel=Viewmodel()
    // @State var songList: SongList?
    // songList.data是【songlist】
    // viewmodel中的instrus的每个songGroup.songList是【songlist】
    var body:some View{
        NavigationView{
            VStack(alignment:.leading){
                Image("testpic")
                ForEach(viewmodel.instrus){instru in
                //instru是songGroup类型
                InstruCell(instru: instru)
                    .animation(.default, value: 0)
                    .environmentObject(viewmodel)
                }
            }
            .navigationTitle("每日推荐")
        }
    }
    
//    func fetchData() {
//        let url = URL(string: "http://123.60.156.14:5000/music_all")!
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//                if let songList = try? decoder.decode(SongList.self, from: data) {
//                    DispatchQueue.main.async {
//                        self.songList = songList
//                    }
//                }
//            }
//        }.resume()
//    }
}

class Viewmodel:ObservableObject{
    @Published var instrus:[SongGroup]=[
        SongGroup(instru: "打击乐器", songList: sampleSong),
        SongGroup(instru: "吹管乐器", songList: sampleSong),
        SongGroup(instru: "弹拨乐器", songList: sampleSong),
        SongGroup(instru: "拉弦乐器", songList: sampleSong),
    ]
    
    init() {
        // fetchData()
        fetchDataType(for: "打击乐器",index: 0)
        fetchDataType(for: "吹管乐器",index: 1)
        fetchDataType(for: "弹拨乐器",index: 2)
        fetchDataType(for: "拉弦乐器",index: 3)
    }
    
    // 初始化SongGroup列表
    // 获得所有乐曲
    func fetchData() {
        let url = URL(string: "http://123.60.156.14:5000/music_all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let songList = try? decoder.decode(SongList.self, from: data) {
                    DispatchQueue.main.async {
                        for i in 0..<self.instrus.count {
                            _ = self.instrus[i] //instru是songGroup类型
                            self.instrus[i].songList = songList.data
                        }
                    }
                }
            }
        }.resume()
    }
    
    // 获得对应类型的乐曲
    func fetchDataType(for type: String, index: Int) {
        if let encodedString = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let urlString = "http://123.60.156.14:5000/music_inst_type?type=\(encodedString)"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let songList = try? decoder.decode(SongList.self, from: data) {
                        DispatchQueue.main.async {
                            self.instrus[index].songList = songList.data
                        }
                    }
                }
            }.resume()
        }
    }

//    func fetchDataType(for type: String,index: Int) {
//        let urlString = "http://123.60.156.14:5000/music_inst_type?type=\(type)"
//        print(urlString)
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//                if let songList = try? decoder.decode(SongList.self, from: data) {
//                    DispatchQueue.main.async {
//                            self.instrus[index].songList = songList.data
//                    }
//                }
//            }
//        }.resume()
//    }

    func expand(_ instru:SongGroup){
        var instrus=self.instrus
        instrus=instrus.map{
            var tempVar=$0
            tempVar.expanded=($0.id==instru.id) ? !tempVar.expanded : tempVar.expanded
            return tempVar
        }
        self.instrus=instrus
    }
}


struct StyleTransfer: View {
    var body: some View {
        NavigationView{
            ContentView()  //显示歌曲列表
            NavigationLink(destination:SongChoose(song:sampleSong[0])){
            }
            .navigationTitle("歌曲列表")
        }
    }
}

struct StyleTransfer_Previews: PreviewProvider {
    static var previews: some View {
        StyleTransfer().environmentObject(AppSettings())
    }
}

