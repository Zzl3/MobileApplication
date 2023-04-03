//
//  BaseView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/3.
//

import SwiftUI

struct BaseView: View {
    @State var currentTab = "house.fill"
    init(){
        UITabBar.appearance().isHidden=true
    }
    
    @State var curveAxis:CGFloat=0
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $currentTab){
                Introduction()
                    .tag("music.note.list")
                StyleTransfer()
                    .tag("music.note.house")
                MySetting()
                    .tag("person.circle")
                
            }
            .clipShape(
                CustomTab(curveAxis: curveAxis)
            )
            .padding(.bottom,-90)
            HStack(spacing: 0){
                TabButton()
            }
            .frame(height:50)
            .padding(.horizontal,35)
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.451, green: 0.511, blue: 0.388)/*@END_MENU_TOKEN@*/)
        .foregroundColor(.white)
        .ignoresSafeArea(.container,edges: .top)
    }
       
    @ViewBuilder
    func TabButton()->some View{
        ForEach(["music.note.list","music.note.house","person.circle"],id:\.self){
            image in
            GeometryReader{
                proxy in
                Button{
                    withAnimation{
                        currentTab=image
                        curveAxis=proxy.frame(in: .global).midX
                    }
                }label: {
                    Image(systemName: image)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 45,height: 45)
                        .background(
                            Circle()
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.451, green: 0.511, blue: 0.388)/*@END_MENU_TOKEN@*/)
                                
                        )
                        .offset(y: currentTab == image ? -25 : 0)
                }
                .frame(maxWidth: .infinity,alignment: .center)
                .onAppear{
                    if curveAxis == 0 && image == "music.note.list"{
                        curveAxis = proxy.frame(in: .global).midX
                    }
                }
                
            }
            .frame(height:40)
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
