//
//  StyleTransfer.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

//推荐轮播图
//轮播图Model
import SwiftUI

struct CarouselCard: Identifiable,Codable{
    var id:     Int
    var name:   String = ""
        //安全初始化
    fileprivate init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}
//轮播图ViewModel
class CarouselViewModel: ObservableObject{
    //轮播内容
    var items = [CarouselCard]()
    private func addItems(named name: String){
        let item = CarouselCard(name: name, id: items.count)
        items.insert(item, at: item.id)
    }
    init() {
        if items.isEmpty {
            addItems(named: "testpic")
            addItems(named: "testpic2")
            addItems(named: "testpic3")
        }
    }
}

struct Carousel: View {
    @StateObject var carousels = CarouselViewModel()
    @State var screenDrag:CGFloat = 1 //拖放时偏移
    @State var activeCard = 0 //当前展示项
    //@State var picarray=["testpic1","testpic2","testpic3"]
    var numberOfItems:CGFloat{ CGFloat(carousels.items.count) } //轮播项总数
    var cardWidth:CGFloat{ UIScreen.main.bounds.width - (CarouselConstants.widthOfHiddenCards * 2) - (CarouselConstants.spacing * 2 ) }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + (numberOfItems - 1) * CarouselConstants.spacing //容器总宽度=卡片*宽度 + 总间距
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = CarouselConstants.widthOfHiddenCards + CarouselConstants.spacing
        let totalMovement = cardWidth + CarouselConstants.spacing
            //当前正确位置
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(activeCard))
            //下一个位置
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(activeCard) + 1)
            //最终确定偏移位置
        let calcOffset = (activeOffset != nextOffset) ? activeOffset + screenDrag : activeOffset
        
        return HStack(spacing: CarouselConstants.spacing) {
            ForEach(carousels.items) { item in
                Image(item.name)    //推荐图片
                    .frame(width: UIScreen.main.bounds.width - (CarouselConstants.widthOfHiddenCards * 2) - (CarouselConstants.spacing * 2),
                           height: (item.id == activeCard) ? CarouselConstants.cardHeight : CarouselConstants.cardHeight - 30)                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(8)
                    .shadow(color: Color.gray, radius:4, x:0, y:4)
                    .onAppear{
                        activeCard = Int(numberOfItems / 2)//跳转到中间位置
                    }
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .offset(x:calcOffset)
        .gesture(panGesture())//拖动手势
        .frame(maxWidth: .infinity)
        .animation(.spring(),value:activeCard)//监听动画iOS 15
    }
    
    @GestureState private var gesturePanOffset:CGFloat = .zero //手势结束会恢复初值
    //手势定义
    private func panGesture() -> some Gesture{
        DragGesture()
            .updating($gesturePanOffset){ lastestGestureValue, _, _ in
                screenDrag =  lastestGestureValue.translation.width
            }
            .onEnded{ value in
                screenDrag = 0
                let moveOffset = UIScreen.main.bounds.width / 4 //超过屏幕宽度（计算后的值）才发生偏移
                let lastIndex = carousels.items.endIndex - 1//数组最后一个索引值
                    //向右拖动
                if value.translation.width > moveOffset{
                    activeCard = (activeCard <= 0) ? lastIndex : activeCard - 1
                }
                    //向左拖动
                if -value.translation.width > moveOffset{
                    activeCard = activeCard >= lastIndex ? 0 : activeCard + 1
                }
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
    }
        //参数控制器
    private struct CarouselConstants{
        static let spacing:            CGFloat = 8 //与隐藏卡片的左右间距
        static let widthOfHiddenCards: CGFloat = 1 //被隐藏卡片的宽度(左、右)
        static let cardHeight:         CGFloat = 240 //卡片高度
    }
}

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
                        .foregroundColor(.primary)
                    
                    Text(instru.artist)
                        .font(.footnote)
                        .foregroundColor(.primary)
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
            .foregroundColor(Color.primary)
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
    //
    //
    private var sectionHeader:some View{
            VStack(spacing:0){
                HStack{
                    Text(instru.instru)
                        .padding(.vertical,10)
                        
                        .fontWeight(.bold)
                        .font(.system(size:20))
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
            ZStack{
                Color.clear
                    .background(Image("huawen2")
                        .position(x:100,y:1600)
                        .scaleEffect(0.1)
                        .padding())
                VStack(alignment:.leading){
                    Carousel()
                        .frame(height:200)
                        .position(x:195,y:150)
                        .scaleEffect(0.9)
                    NavigationLink(destination: UploadFile(song:sampleSong[0])) {
                        Text("上传歌曲")
                           .fontWeight(.bold)
                           .foregroundColor(.primary)
                           .padding()
                           .background(Color("DeepGreen"))
                           .cornerRadius(10)
                           .padding(.horizontal,140)

                    }
                    Text("乐器选择")
                        .font(.system(size:30))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.primary)
                        .position(x:80,y:100)
                        .frame(height:110)
                        .padding(.top,-40)
                    ScrollView{
                        ForEach(viewmodel.instrus){instru in
                            //instru是songGroup类型
                            InstruCell(instru: instru)
                                .animation(.default, value: 0)
                                .environmentObject(viewmodel)
                            
                        }
                    }
                    
                    
                }
                .navigationTitle("每日推荐")
            }
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

