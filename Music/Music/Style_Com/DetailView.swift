//
//  DetailView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//

import SwiftUI

struct DetailView:View{
    var animation:Namespace.ID
    var album:Album
    var song:Song
    @Binding var show:Bool
    @State var ifPause:Bool=false
    @State var ifLove:Bool=false
    var body: some View{
        VStack{
            HStack{
                Button{
                    withAnimation(.easeInOut(duration: 0.35)){
                        show=false
                    }
                } label: {
                    Text("试试其他")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(15)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            Circle()
                .fill(Color("LightGreen"))
                .frame(width: 10,height:  10)
                .padding(4)
                .background{
                        Circle()
                            .stroke(Color("DeepGreen"),lineWidth: 2)
                            .matchedGeometryEffect(id: "INDICATOR", in: animation)
                }
            
            HStack(spacing:20){
                Button(action:{
                    print("download")
                }){
                    ZStack{
                        Circle()
                            .frame(width: 50,height: 50)
                            .accentColor(Color("LightGreen"))
                            .shadow(radius: 10)
                        Image(systemName: "arrow.down.to.line.alt")
                            .foregroundColor(Color("DeepGreen"))
                            .font(.system(.title2))
                            .rotationEffect(.degrees(0))
                    }
                }
                
                Button(action:{
                    print("Rewind")
                }){
                    ZStack{
                        Circle()
                            .frame(width: 50,height: 50)
                            .accentColor(Color("LightGreen"))
                            .shadow(radius: 10)
                        Image(systemName: "backward.fill")
                            .foregroundColor(Color("DeepGreen"))
                            .font(.system(.title2))
                            .rotationEffect(.degrees(0))
                    }
                }
                
                Button(action:{
                    print("Pause")
                    ifPause = !ifPause
                }){
                    ZStack{
                        Circle()
                            .frame(width: 50,height: 50)
                            .accentColor(Color("LightGreen"))
                            .shadow(radius: 10)
                        if ifPause == false{
                            Image(systemName: "pause.fill")
                                .foregroundColor(Color("DeepGreen"))
                                .font(.system(.title2))
                                .rotationEffect(.degrees(0))
                        }else{
                            Image(systemName: "play.fill")
                                .foregroundColor(Color("DeepGreen"))
                                .font(.system(.title2))
                                .rotationEffect(.degrees(0))
                        }
                       
                    }
                }
                
                Button(action:{
                    print("Skip")
                }){
                    ZStack{
                        Circle()
                            .frame(width: 50,height: 50)
                            .accentColor(Color("LightGreen"))
                            .shadow(radius: 10)
                        Image(systemName: "forward.fill")
                            .foregroundColor(Color("DeepGreen"))
                            .font(.system(.title2))
                            .rotationEffect(.degrees(0))
                    }
                }
                
                Button(action:{
                    print("love")
                    ifLove = !ifLove
                }){
                    ZStack{
                        Circle()
                            .frame(width: 50,height: 50)
                            .accentColor(Color("LightGreen"))
                            .shadow(radius: 10)
                        if ifLove == false{
                            Image(systemName: "heart")
                                .foregroundColor(Color("DeepGreen"))
                                .font(.system(.title2))
                                .rotationEffect(.degrees(0))
                        }else{
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color("DeepGreen"))
                                .font(.system(.title2))
                                .rotationEffect(.degrees(0))
                        }
                       
                    }
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongChoose(song:sampleSong[0])
    }
}
