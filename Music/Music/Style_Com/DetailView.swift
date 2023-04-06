//
//  DetailView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//

import SwiftUI
import AVKit

struct DetailView:View{
    var animation:Namespace.ID
    var album:Album
    var song:Song
    var oldAlbum=Album(albumName: "古筝", albumImage: "Instru_guzheng",introduction:"古筝简单介绍")
    
    
    let url=URL(fileURLWithPath:Bundle.main.path(forResource: "musictest", ofType: "mp3")!)
    @State var audioPlayer: AVAudioPlayer?
    
    @State var oldSliderValue = 0.0
    @State var newSliderValue = 0.0
    @Binding var show:Bool
    @State var oldIfPause:Bool=true
    @State var newIfPause:Bool=false
    @State var oldIfLove:Bool=false
    @State var newIfLove:Bool=false
    var body: some View{
        ZStack{
//            Image(song.songImage)
//                .resizable()
//                .opacity(0.05)
//                .aspectRatio(contentMode: .fill)
//                .edgesIgnoringSafeArea(.top)
            VStack{
                //返回键（左上角）
                HStack{
                    Button{
                        withAnimation(.easeInOut(duration: 0.35)){
                            show=false
                        }
                    } label: {
                        Label("试试其他",systemImage: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(15)
    //                    Text("试试其他")
    //                        .font(.title2)
    //                        .foregroundColor(.black)
    //                        .padding(15)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding()
                
                //歌曲信息：图片，歌名，
                VStack{
                    ZStack{
                        Circle()
                            .fill(Color("LightGreen"))
                            .frame(width: 250,height:  250)
                            .shadow(radius: 10)
                        
                        Circle()
                            .fill(Color("DeepGreen"))
                            .frame(width: 225,height:  225)
                            .shadow(radius: 10)
                        
                        Image(song.songImage)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(2.5)
                            .frame(width:200,height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    
                    Text(song.songName)
                        .font(Font.system(.title).bold())
                    Text(song.author)
                        .font(.system(.headline))
                }
                .padding()
                
                //原来歌曲的版本：乐器名+波形图+三个按钮（下载，暂停/播放，收藏）+乐器背景图片
                ZStack{
                    Image(oldAlbum.albumImage)
                        .resizable()
                        .frame(width: 200,height: 100)
                        .opacity(0.3)
                        
                    
                    VStack{
                        HStack{
                            Text(oldAlbum.albumName)
                        }
                        .font(.title2)
                        
                        Slider(value: $oldSliderValue, in: 0...5, step: 0.1)
                            .frame(width: 300)
                        
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
                            
    //                        Button(action:{
    //                            print("Rewind")
    //                        }){
    //                            ZStack{
    //                                Circle()
    //                                    .frame(width: 50,height: 50)
    //                                    .accentColor(Color("LightGreen"))
    //                                    .shadow(radius: 10)
    //                                Image(systemName: "backward.fill")
    //                                    .foregroundColor(Color("DeepGreen"))
    //                                    .font(.system(.title2))
    //                                    .rotationEffect(.degrees(0))
    //                            }
    //                        }
                            
                            Button(action:{
                                print("Pause")
                                oldIfPause = !oldIfPause
                                if(oldIfPause==true){
                                    do {
                                    //尝试使用预设的声音播放器获取目标文件
                                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                                    //播放声音
                                    audioPlayer?.stop()
                                        } catch {
                                            //加载文件失败，这里用于防止应用程序崩溃
                                    }
                                }else{
                                    do {
                                    //尝试使用预设的声音播放器获取目标文件
                                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                                    //停止播放
                                    audioPlayer?.play()
                                        } catch {
                                            //加载文件失败，这里用于防止应用程序崩溃
                                    }
                                }
                                
                            }){
                                ZStack{
                                    Circle()
                                        .frame(width: 50,height: 50)
                                        .accentColor(Color("LightGreen"))
                                        .shadow(radius: 10)
                                    if oldIfPause == false{
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
                            
    //                        Button(action:{
    //                            print("Skip")
    //                        }){
    //                            ZStack{
    //                                Circle()
    //                                    .frame(width: 50,height: 50)
    //                                    .accentColor(Color("LightGreen"))
    //                                    .shadow(radius: 10)
    //                                Image(systemName: "forward.fill")
    //                                    .foregroundColor(Color("DeepGreen"))
    //                                    .font(.system(.title2))
    //                                    .rotationEffect(.degrees(0))
    //                            }
    //                        }
                            
                            Button(action:{
                                print("love")
                                oldIfLove = !oldIfLove
                            }){
                                ZStack{
                                    Circle()
                                        .frame(width: 50,height: 50)
                                        .accentColor(Color("LightGreen"))
                                        .shadow(radius: 10)
                                    if oldIfLove == false{
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
                    .frame(width: 400,height: 100)
                }
                .padding(.top,40)
                
                
                //风格迁移后歌曲的版本：乐器名+波形图+三个按钮（下载，暂停/播放，收藏）+乐器背景图片
                
                ZStack{
                    Image(album.albumImage)
                        .resizable()
                        .frame(width: 200,height: 100)
                        .opacity(0.3)
                    
                    VStack{
                        
                        HStack{
                            Text(album.albumName)
                                .font(.title2)
                        }
                        
                        Slider(value: $newSliderValue, in: 0...5, step: 0.1)
                        
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
                            
    //                        Button(action:{
    //                            print("Rewind")
    //                        }){
    //                            ZStack{
    //                                Circle()
    //                                    .frame(width: 50,height: 50)
    //                                    .accentColor(Color("LightGreen"))
    //                                    .shadow(radius: 10)
    //                                Image(systemName: "backward.fill")
    //                                    .foregroundColor(Color("DeepGreen"))
    //                                    .font(.system(.title2))
    //                                    .rotationEffect(.degrees(0))
    //                            }
    //                        }
                            
                            Button(action:{
                                print("Pause")
                                newIfPause = !newIfPause
                            }){
                                ZStack{
                                    Circle()
                                        .frame(width: 50,height: 50)
                                        .accentColor(Color("LightGreen"))
                                        .shadow(radius: 10)
                                    if newIfPause == false{
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
                            
    //                        Button(action:{
    //                            print("Skip")
    //                        }){
    //                            ZStack{
    //                                Circle()
    //                                    .frame(width: 50,height: 50)
    //                                    .accentColor(Color("LightGreen"))
    //                                    .shadow(radius: 10)
    //                                Image(systemName: "forward.fill")
    //                                    .foregroundColor(Color("DeepGreen"))
    //                                    .font(.system(.title2))
    //                                    .rotationEffect(.degrees(0))
    //                            }
    //                        }
                            
                            Button(action:{
                                print("love")
                                newIfLove = !newIfLove
                            }){
                                ZStack{
                                    Circle()
                                        .frame(width: 50,height: 50)
                                        .accentColor(Color("LightGreen"))
                                        .shadow(radius: 10)
                                    if newIfLove == false{
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
                    .frame(width: 400,height: 100)
                }
                .padding(.top,50)
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .background(
                Image(song.songImage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.05)
             )
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongChoose(song:sampleSong[0])
    }
}
