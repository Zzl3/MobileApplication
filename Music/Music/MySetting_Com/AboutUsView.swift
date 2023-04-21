//
//  AboutUsView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI
struct BackView:View{
    var body :some View{
        VStack{
            Rectangle()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color("About_us_Green_1"))
        }
        .ignoresSafeArea()
        .overlay(
            VStack{
                Circle()
                    .foregroundColor(Color("About_us_Green_2"))
                    .frame(height:475)
                    .position(x:220,y:-110)
                Circle()
                    .foregroundColor(Color("About_us_Green_2"))
                    .frame(height:475)
                    .position(x:550,y:390)
              
            }
        )
        .overlay(
            VStack{
                Circle()
                    .foregroundColor(Color("About_us_Green_3"))
                    .frame(height:400)
                    .position(x:200,y:-145)
                Circle()
                    .foregroundColor(Color("About_us_Green_3"))
                    .frame(height:400)
                    .position(x:590,y:420)
            }
        )
        .overlay(
            VStack{
                Image("vector_336")
                    .scaleEffect(0.9)
                    .position(x:240,y:70)
                Image("vector_334")
                    .scaleEffect(0.9)
                    .position(x:400,y:410)
                Image("vector_335")
                    .scaleEffect(0.9)
                    .position(x:445,y:200)
                
            }
        )
        .overlay(
            Image("huawen3")
                .scaleEffect(0.9)
                .opacity(0.6)
                .position(x:480,y:340)
        )
        .overlay(
        ZStack{
            
            Circle()
                .foregroundColor(.white)
                .frame(height:8)
                .position(x:320,y:30)
            Circle()
                .foregroundColor(.white)
                .frame(height:7)
                .position(x:250,y:40)
            Circle()
                .foregroundColor(.white)
                .frame(height:6)
                .position(x:240,y:80)
            Circle()
                .foregroundColor(.white)
                .frame(height:6)
                .position(x:193,y:135)
            Circle()
                .foregroundColor(.white)
                .frame(height:6)
                .position(x:370,y:710)
            Circle()
                .foregroundColor(.white)
                .frame(height:7)
                .position(x:400,y:640)
            Circle()
                .foregroundColor(.white)
                .frame(height:6)
                .position(x:420,y:750)
            Circle()
                .foregroundColor(.white)
                .frame(height:8)
                .position(x:560,y:620)
            Image("About_us")
                .scaleEffect(1.1)
                .position(x:490,y:500)
            Text("关于我们")
                .foregroundColor(.white)
                .position(x:490,y:550)
                .fontWeight(.medium)
            
        }
       )    }
}
struct TechnologyView:View{
    
    var body :some View{
        VStack{
            Text("Technology")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .padding()
                .position(x:260,y:180)
            Text("最优化的")
                .fontWeight(.bold)
                .frame(width:220)
                .position(x:270,y:20)
                .foregroundColor(.white)
                .font(.system(size:40))
                .padding()
            Text("技术")
                .fontWeight(.bold)
                .frame(width:220)
                .position(x:230,y:-130)
                .foregroundColor(.white)
                .font(.system(size:40))
                .padding()
            Text("顺应当下深度学习迅速发展的趋势，结合音乐领域相关知识，针对不同乐器风格，获取音调、语谱图等数据，选择当前神经网络算法并加以改进优化")
                .frame(width:245)
                .position(x:330,y:-160)
                .foregroundColor(.white)
          
        }
        .overlay(
            ZStack{
                Circle()
                    .frame(width:13)
                    .foregroundColor(.white)
                    .position(x:230,y:550)
                Circle()
                    .frame(width:13)
                    .foregroundColor(Color("gray_white"))
                    .position(x:260,y:550)
            }
        )
    }
}
struct ExperienceView:View{
    var body:some View{
        VStack{
            Text("Experience")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .padding()
                .position(x:260,y:180)
            Text("最极致的")
                .fontWeight(.bold)
                .frame(width:220)
                .position(x:270,y:20)
                .foregroundColor(.white)
                .font(.system(size:40))
                .padding()
            Text("体验")
                .fontWeight(.bold)
                .frame(width:220)
                .position(x:230,y:-130)
                .foregroundColor(.white)
                .font(.system(size:40))
                .padding()
            Text("希望能够通过我们让您在了解中国传统乐器的同时发现到同一个曲子的不同乐器演奏风格的美妙")
                .frame(width:245)
                .position(x:330,y:-160)
                .foregroundColor(.white)
        }
        .overlay(
            ZStack{
                Circle()
                    .frame(width:13)
                    .foregroundColor(Color("gray_white"))
                    .position(x:230,y:550)
                Circle()
                    .frame(width:13)
                    .foregroundColor(.white)
                    .position(x:260,y:550)
            }
        )
        
    }
}


struct AboutUsView: View {
    let screenSize = UIScreen.main.bounds.size
    @EnvironmentObject var appSettings: AppSettings
    @State var tech  = true
    
    var body: some View {
        BackView()
        .overlay(
            ZStack{
                if tech{
                    TechnologyView()
                }
                else{
                    ExperienceView()
                }
            }
        )
        
        .gesture(
        DragGesture()
            .onChanged{value in
                if value.translation.width > 0{
                    tech = false
                }
                else{
                    tech = true
                }
            }
            .onEnded{value in
                if value.translation.width > 0{
                    tech = false
                }
                else{
                    tech = true
                }
            }
        )
        .animation(
            .spring()
        )
    }
}
        
        
        
        
        



struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView().environmentObject(AppSettings())
    }
}
