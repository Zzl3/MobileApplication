//
//  SongChoose.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//

import SwiftUI

struct SongChoose: View {
    @State var currentIndex:Int=0
    @State var currentTab:InstruTab=tabs[0]
    @Namespace var animation
    var song:Song
    
    @State var selectedInstru:Album?
    @State var showDetail: Bool = false //显示详情
    var body: some View {
        VStack{
            HeaderView(song: song, ifPause: false) //示例，传给他一首曲子
                .padding(.top,80)
            
            GeometryReader{proxy in
                let size = proxy.size
                CarouselView(size: size)
            }
            .padding(.top,0)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay(content:{
            if let selectedInstru,showDetail{
                DetailView(animation: animation, album: selectedInstru, song: song, show: $showDetail)
            }
        })
        .background(Color("DeepGreen"))
        .padding(.bottom,130)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func CarouselView(size:CGSize)->some View{
        VStack(spacing:-40){
            CustomCarousel(index:$currentIndex, items: sampleAlbums,spacing: 30,cardPadding: size.width / 3 ,id: \.id){
                sampleAlbums,size in
                VStack(spacing:10){
                    ZStack{
                        if showDetail && selectedInstru?.id == sampleAlbums.id{
                            Image(sampleAlbums.albumImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                        }else{
                            Image(sampleAlbums.albumImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .matchedGeometryEffect(id: sampleAlbums.id, in: animation)
                        }
                    }
                    .background{
                        RoundedRectangle(cornerRadius: size.height / 10 ,style: .continuous)
                            .fill(Color("LightGreen"))
                            }
                        
                    Text(sampleAlbums.albumName)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.top,8)
                        .bold()
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.8)){
                        selectedInstru = sampleAlbums
                        showDetail = true
                    }
                }
            }
            .frame(height: size.height * 0.8)
            Indicators()
        }
        .frame(width: size.width,height: size.height,alignment: .bottom)
        .opacity(showDetail ? 0 : 1)
        .background{
            CustomArcShape()
                .fill(.white)
                .scaleEffect(showDetail ? 1.8 : 1,anchor:.bottomLeading)
                .overlay(alignment: .topLeading, content: {
                    TabMenu()
                        .opacity(showDetail ? 0 : 1)
                })
                .padding(.top,20)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func TabMenu()->some View{
        HStack(spacing:30){
            ForEach(tabs){tab in
                Image(tab.tabImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40,height: 50)
                    .padding(10)
                    .background{
                        Circle()
                            .fill(Color("LightGreen"))
                    }
                    .background(content: {
                        Circle()
                            .fill(.white)
                            .padding(-2)
                    })
                    .shadow(color:.black.opacity(0.07),radius:5,x:5,y:5)
                    .offset(tab.tabOffset)
                    .scaleEffect(currentTab.id == tab.id ? 1.15 : 0.94,anchor: .bottom)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            currentTab = tab
                        }
                    }
            }
        }
        .padding(.leading,15)
    }
    
    @ViewBuilder
    func Indicators()->some View{
        HStack(spacing:2){
            ForEach(sampleAlbums.indices,id: \.self){index in
                Circle()
                    .fill(Color("LightGreen"))
                    .frame(width: currentIndex == index ? 10 : 6,height: currentIndex == index ? 10 : 6)
                    .padding(4)
                    .background{
                        if currentIndex == index{
                            Circle()
                                .stroke(Color("DeepGreen"),lineWidth: 2)
                                .matchedGeometryEffect(id: "INDICATOR", in: animation)
                        }
                    }
                
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
}

struct SongChoose_Previews: PreviewProvider {
    static var previews: some View {
        StyleTransfer()
    }
}


