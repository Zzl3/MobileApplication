//
//  AboutUsView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct AboutUsView: View {
    @EnvironmentObject var appSettings: AppSettings
    var body: some View {
        VStack{
            
            Image("Circulo")
                .scaleEffect(1)
                .position(x:280,y:250)
            Image("Circulo")
                .scaleEffect(0.85)
                .position(x:130,y:270)
            
            Image("huawen3")
                .scaleEffect(0.85)
                .position(x:180,y:130)
            
            Spacer()
        }
        .overlay{
            VStack{
                
                    Text("XX顺应当下深度学习迅速发展的趋势，结合音乐领域相关知识，针对不同乐器风格，获取音调、语谱图等数据，选择当前神经网络算法并加以改进优化")
                    .foregroundColor(Color("DeepGreen"))
                    .frame(width:260)
                    .lineSpacing(5)
                    .position(x:250,y:220)
                    .font(.system(size:17))
                    .fontWeight(.medium)
                    Text("希望能够通过XX让您在了解中国传统乐器的同时发现到同一个曲子的不同乐器演奏风格的美妙")
                    .foregroundColor(Color("DeepGreen"))
                    .frame(width:195)
                    .lineSpacing(5)
                    .position(x:140,y:155)
                    .font(.system(size:17))
                    .fontWeight(.medium)
                
            }
        }
        .overlay{
            VStack{
                Image("Artista")
                    .position(x:150,y:380)
            }
        }
        .overlay{
            VStack{
                Image("About_us")
                    .scaleEffect(1.3)
                    .position(x:150,y:370)
                Text("关于xx")
                    .foregroundColor(.white)
                    .font(.system(size:20))
                    .fontWeight(.heavy)
                    .position(x:150,y:30)
            }
        }
    }
}



struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView().environmentObject(AppSettings())
    }
}
