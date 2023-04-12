//
//  MySetting.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI



struct MySetting: View {
//    @Environment(\.colorScheme) var colorScheme: ColorScheme
//    @EnvironmentObject var appSettings: AppSetting
    
//    @State var showMenu = false
//    @State var showReply = false
//    @State var viewState = CGSize.zero
//    @State var showContent = false
    @State var showingSheet = false
    @State var showHistory = false
    @State var showCollection = false
    @State var showFeedback = false
    @State var showAboutUs = false
//

    
    @Namespace var namespace
    
    var body: some View {

        
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 30) {
                    PersonView()
                }.padding(.vertical, 20.0)
            }
            .navigationTitle("Today")
            .toolbar {
                
                Button(action: {
                    showingSheet.toggle()
                }) {
                    Image("img_head_default")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .cornerRadius(16)
                }
                .sheet(isPresented: $showingSheet) {
                    ProfileView()
                }
                
            }
        }
        .navigationViewStyle(.stack)

    }
    
    
}

struct MenuRow: View{
    var image="creditcard"
    var text="历史记录"
    var body: some View{
        return HStack(spacing:12){
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(Color.black)
                .frame(width:50,height: 50)
            Text(text)
                .font(.title)
                .font(.headline)
                //.foregroundColor(.black)
            Spacer()
        }
        //.shadow(radius: 5)
    }
}
//
//struct Menu : Identifiable{
//    var id = UUID()
//    var title : String
//    var icon : String
//    var show : Bool
//}
//
//
//
//struct MenuView : View {
////    @State var menu = [
////        Menu(title: "a", icon: "heart", show: false),
////        Menu(title: "a", icon: "heart", show: false),
////        Menu(title: "a", icon: "heart", show: false),
////        Menu(title: "a", icon: "heart", show: false)
////    ]
//    @Binding var showMenu : Bool
//    @State var showHistory = false
//    @State var showCollection = false
//    @State var showFeedback = false
//    @State var showAboutUs = false
//    @State var isDeep = false
//
//    //@EnvironmentObject var appSettings: AppSetting
//
//
//    var body: some View {
//        return ZStack {
////            Image("huawen")
////                .resizable()
//
//            VStack(alignment: .leading, spacing:20){
//                MenuRow(image: "arrowshape.turn.up.backward",text: "返回")
//                    .onTapGesture {
//                        self.showMenu.toggle()
//                    }
//
//                //深色模式
//                ZStack{
//
//                    Button(action: {
//                       // appSettings.darkModeSettings=2
//
//                    }) {
//                        MenuRow(image: "light.min",text: "deep")
//                    }
//
////                    MenuRow(image: "light.min",text: "深色模式")
////                    Toggle("",isOn: $isDeep)
////                        .font(.title)
////                        .font(.headline)
//                }
//
//
//
////                Button(action: { self.showHistory.toggle() }) {
////                    MenuRow(image: "record.circle",text: "历史记录")
////                }
////                .sheet(isPresented: $showHistory) {
////                    //HistoryView(showHistory: $showHistory)
////                }
//                //.foregroundColor(Color.black)
//
////                Button(action: { self.showCollection.toggle() }) {
////                    MenuRow(image: "bookmark.circle",text: "我的收藏")
////                }
////                .sheet(isPresented: $showCollection) {
////                    CollectionView(showCollection: $showCollection)
////                }
////                //.foregroundColor(Color.black)
////
////                Button(action: { self.showFeedback.toggle() }) {
////                    MenuRow(image: "applepencil",text: "提交反馈")
////                }
////                .sheet(isPresented: $showFeedback) {
////                    FeedBack(showFeedback: $showFeedback)
////                }
////                //.foregroundColor(Color.black)
////
////                Button(action: { self.showAboutUs.toggle() }) {
////                    MenuRow(image: "person.bust",text: "关于我们")
////                }
////                .sheet(isPresented: $showAboutUs) {
////                    AboutUsView(showAboutUs: $showAboutUs)
////                }
//                //.foregroundColor(Color.black)
//
//                Spacer()
//
//            }
//            .background(
//                Image("huawen2")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 400,height: 900)
//                    //.background(Color("LightGreen"))
//                    .opacity(0.3)
//            )
//            //.padding(.top,20)
//            .padding(30)
//            .frame(minWidth: 0,maxWidth: .infinity)
//            .background(Color.white)
//            .cornerRadius(30)
//            .padding(.trailing,60)
//            .shadow(radius: 20)
//            .rotation3DEffect(Angle(degrees: showMenu ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
//            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
//            //.animation(.basic())
//            .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
//        }
//
////        .tapAction{
////            self.show.toggle()
////        }
//        //.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
//
//
//    }
//}

struct MySetting_Previews: PreviewProvider {
    static var previews: some View {
        MySetting().environmentObject(AppSettings())
    }
}


//struct CircleButton: View {
//    var icon = "person.crop.circle"
//    var body: some View {
//        HStack{
//            //Spacer()
//            Image(systemName: icon)
//                .foregroundColor(.black)
//        }
//        .frame(width: 44,height: 44)
//        .background(Color.white)
//        .cornerRadius(30)
//        .shadow(radius: 10,x: 0,y:10)
//    }
//}
//
//struct MenuButton: View {
//    @Binding var showMenu : Bool
//    var body: some View {
//        return VStack(alignment: .trailing) {
//            HStack {
//                ZStack(alignment: .topLeading) {
//                    Button(action:{self.showMenu.toggle()}) {
//                        HStack{
//                            Spacer()
//                            Image(systemName: "list.dash")
//                                .foregroundColor(.black)
//                        }
//                        .padding(.trailing,20)
//                        .frame(width: 90,height: 60)
//                        .background(Color.white)
//                        .cornerRadius(30)
//                        .shadow(radius: 10,x: 0,y:10)
//                    }
//                    Spacer()
//                }
//                Spacer()
//            }
//            Spacer()
//        }
//    }
//}
//
//struct MenuRight: View {
//    @Binding var show : Bool
//    var body: some View {
//        return VStack() {
//            HStack {
//                Spacer()
//                ZStack(alignment: .topTrailing) {
//                    HStack{
////                        Button(action:{self.show.toggle()}) {
////                            CircleButton(icon:"person.crop.circle")
////                        }
//                        Button(action:{self.show.toggle()}) {
//                            CircleButton(icon:"bell")
//                        }
//                    }
//                    Spacer()
//                }
//            }
//            Spacer()
//        }
//    }
//}
