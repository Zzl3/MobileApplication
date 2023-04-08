//
//  DetailView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//

import SwiftUI
import AVKit
import UIKit
import AVFoundation

struct DetailView:View{
    var animation:Namespace.ID
    var album:Album
    var song:Song
//    var oldAlbum=Album(albumName: "古筝", albumImage: "Instru_guzheng",introduction:"古筝简单介绍")
    
    @State var data : Data = .init(count: 0)
    @State var title = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["musictest","test2"] // 总音频列表
    @State var current = 0 // 当前播放的第几首音频
    @State var finish = false // 是否播放完成
    @State var del = AVDelegate() // 播放器的代理
    
    //可拖动的进度条
    let url=URL(fileURLWithPath:Bundle.main.path(forResource: "musictest", ofType: "mp3")!)
    @State var audioPlayer: AVAudioPlayer?
   
//    @State var width:CGFloat = UIScene.main.bounds.height < 750 ? 130 : 230
    
    @State var oldSliderValue = 0.0
    @State var newSliderValue = 0.0
    @Binding var show:Bool
    @State var oldIfPause:Bool=true
    @State var newIfPause:Bool=false
    @State var oldIfLove:Bool=false
    @State var newIfLove:Bool=false
    var body: some View{
        ZStack{
            Image(song.songImage)
                .resizable()
                //.frame(width: 200,height: 100)
                .opacity(0.05)
            
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
                    
                    Image(album.albumImage)
                        .resizable()
                        .frame(width: 300,height: 200)
                        .opacity(0.3)
                    VStack{
                        HStack{
                        Text(album.albumName)
                        }
                        .font(.title2)
                        
//                        Slider(value: $oldSliderValue, in: 0...5, step: 0.1)
//                        .frame(width: 300)
                        
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.black.opacity(0.08)).frame(height:8)
                            // 蓝色进度等于播放进度
                            Capsule().fill(Color.blue).frame(width:self.width,height:8)
                            // 拖拽进度条处理
                                .gesture(DragGesture()
                                    .onChanged({ value in
                                        let x = value.location.x
                                        self.width = x
                                        
                                    })
                                        .onEnded({ value in
                                            let x = value.location.x
                                            let screen = UIScreen.main.bounds.width - 30
                                            // 百分比
                                            let percent = x / screen
                                            self.player.currentTime = Double(percent) * self.player.duration
                                        })
                                )
                        }
                        .frame(width: 300)
                     
                        HStack(spacing:20){
                            //下载按钮
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
                            
                            //上一首按钮
                            Button(action:{
                                // 检测歌曲的索引
                                if self.current > 0{
                                    self.current -= 1
                                    self.ChangeSongs()
                                }
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
                     
                            //暂停/播放
                            Button(action:{
                                if self.player.isPlaying {
                                    self.player.pause()
                                    self.playing = false
                                }
                                else {
                                    if self.finish {
                                        self.player.currentTime = 0
                                        self.width = 0
                                        self.finish = false
                                    }
                                        
                                    self.player.play()
                                    self.playing = true
                                }
                                
                            })
                            {
                                ZStack{
                                    Circle()
                                        .frame(width: 50,height: 50)
                                        .accentColor(Color("LightGreen"))
                                        .shadow(radius: 10)
                                    if playing == true{
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
                     
                            //下一首
                            Button(action:{
                                // 检测歌曲的索引是否越界
                                if self.songs.count - 1 != self.current {
                                    self.current += 1
                                    self.ChangeSongs()
                                }
                            })
                            {
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
                     
                            //收藏
                            Button(action:{
                                print("love")
                                oldIfLove = !oldIfLove
                            })
                            {
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
                            
                        //HStack
                        }
                        .frame(width: 400,height: 100)
                        
                    //VStack
                    }
                    .padding(.top,40)
                    .onAppear{
                        
                        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
                        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                        self.player.prepareToPlay()
                        self.player.delegate = self.del
                        // 获取音频数据 并且把音频数据得到的data存储起来
                        self.getData()
                        
                        // 启动定时器 播放时候 进度同步更新
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                            if self.player.isPlaying {
                                // 测试播放进度
                                //print(self.player.currentTime)
                                let screen = UIScreen.main
                                    .bounds.width - 30
                                
                                let value = self.player.currentTime / self.player.duration
                                
                                self.width = screen * CGFloat(value)
                            }
                        }
                        
                        // 使用通知监听歌曲是否播放完成
                        NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                            self.finish = true
                        }
                    }
                    
                    //风格迁移后歌曲的版本：乐器名+波形图+三个按钮（下载，暂停/播放，收藏）+乐器背景图片
                    
                    
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            }
        }
    }
    func getData(){
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata {
            
            if i.commonKey?.rawValue == "artwork" {
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title"{
                let title = i.value as! String
                self.title = title
                
            }
        }
    }
    
    func ChangeSongs(){
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        self.player.prepareToPlay()
        
        // 切换歌曲 重新初始化音频的数据 比如 data 歌曲的图片 title 歌曲的名称
        self.data = .init(count: 0)
        self.title = ""
        
        self.getData()
        
        
        self.playing = true
        self.finish = false
        self.width = 0
        
        // 切换之后 直接播放歌曲
        self.player.play()
    }
}

    
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongChoose(song:sampleSong[0])
    }
}

// 通过代理监听歌曲是否播放完成
// 使用通知告诉视图 操作播放完成的操作
class AVDelegate : NSObject,AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
