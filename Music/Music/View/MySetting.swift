//
//  MySetting.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI

struct MySetting: View {
    @State var showMenu = false
    @State var showReply = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    
    var body: some View {
        ZStack{
            PersonView()
                .padding(.top, 44)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color.white)
                )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showReply ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showReply ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showReply ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            ReplyView()
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 20)
//                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .offset(y:showReply ? 60 : UIScreen.main.bounds.height)
            
            MenuButton(showMenu: $showMenu)
                .offset(x: -30,y:showReply ? 0 : 80)
            
            MenuRight(show: $showReply)
                .offset(x: -16,y:showReply ? 0 : 80)

            MenuView(showMenu: $showMenu)
        }
        
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

struct Menu : Identifiable{
    var id = UUID()
    var title : String
    var icon : String
    var show : Bool
}



struct MenuView : View {
//    @State var menu = [
//        Menu(title: "a", icon: "heart", show: false),
//        Menu(title: "a", icon: "heart", show: false),
//        Menu(title: "a", icon: "heart", show: false),
//        Menu(title: "a", icon: "heart", show: false)
//    ]
    @Binding var showMenu : Bool
    @State var showHistory = false
    @State var showCollection = false
    @State var showFeedback = false
    @State var showAboutUs = false
    
    var body: some View {
        return ZStack {
            VStack(alignment: .leading, spacing:20){
                MenuRow(image: "arrowshape.turn.up.backward",text: "返回")
                    .onTapGesture {
                        self.showMenu.toggle()
                    }
                
                
                Button(action: { self.showHistory.toggle() }) {
                    MenuRow(image: "record.circle",text: "历史记录")
                }
                .sheet(isPresented: $showHistory) {
                    HistoryView(showHistory: $showHistory)
                }
                .foregroundColor(Color.black)
                
                Button(action: { self.showCollection.toggle() }) {
                    MenuRow(image: "bookmark.circle.fill",text: "我的收藏")
                }
                .sheet(isPresented: $showCollection) {
                    CollectionView(showCollection: $showCollection)
                }
                .foregroundColor(Color.black)
                
                Button(action: { self.showHistory.toggle() }) {
                    MenuRow(image: "applepencil",text: "提交反馈")
                }
                .sheet(isPresented: $showHistory) {
                    HistoryView(showHistory: $showHistory)
                }
                .foregroundColor(Color.black)
                
                Button(action: { self.showAboutUs.toggle() }) {
                    MenuRow(image: "person.bust",text: "关于我们")
                }
                .sheet(isPresented: $showAboutUs) {
                    AboutUsView(showAboutUs: $showAboutUs)
                }
                .foregroundColor(Color.black)
                
                
                
                Spacer()
                    
            }
            //.padding(.top,20)
            .padding(30)
            .frame(minWidth: 0,maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(30)
            .padding(.trailing,60)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: showMenu ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            //.animation(.basic())
            .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
        }
//        .tapAction{
//            self.show.toggle()
//        }
        //.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))

    }
}

struct MySetting_Previews: PreviewProvider {
    static var previews: some View {
        MySetting()
    }
}



struct CircleButton: View {
    var icon = "person.crop.circle"
    var body: some View {
        HStack{
            //Spacer()
            Image(systemName: icon)
                .foregroundColor(.black)
        }
        .frame(width: 44,height: 44)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10,x: 0,y:10)
    }
}

struct MenuButton: View {
    @Binding var showMenu : Bool
    var body: some View {
        return VStack(alignment: .trailing) {
            HStack {
                ZStack(alignment: .topLeading) {
                    Button(action:{self.showMenu.toggle()}) {
                        HStack{
                            Spacer()
                            Image(systemName: "list.dash")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                        .frame(width: 90,height: 60)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 10,x: 0,y:10)
                    }
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct MenuRight: View {
    @Binding var show : Bool
    var body: some View {
        return VStack() {
            HStack {
                Spacer()
                ZStack(alignment: .topTrailing) {
                    HStack{
//                        Button(action:{self.show.toggle()}) {
//                            CircleButton(icon:"person.crop.circle")
//                        }
                        Button(action:{self.show.toggle()}) {
                            CircleButton(icon:"bell")
                        }
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
}
