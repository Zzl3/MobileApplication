//
//  HeaderView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//

import SwiftUI
import AVKit

struct HeaderView: View {
    var song:Song
    @State private var isPlaying = false
    let player = AVPlayer()
    
    var body: some View {
        HStack(spacing:50){
            VStack(spacing:0){
                Image(uiImage: UIImage.fetchImage(from: song.image))
                    .resizable()
                    .padding(.trailing, 7.0)
                    .frame(width: 200,height: 120)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                VStack(spacing:0){
                    Text(song.name)
                        .font(Font.system(.title).bold())
                    Text(song.artist)
                        .font(.system(.headline))
                }
            }
                
            VStack(spacing:20){
                Spacer(minLength: 30)
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
                            .rotationEffect(.degrees(90))
                    }
                }
                
                Button(action: {
                    self.isPlaying.toggle()
                    if self.isPlaying {
                        if let audioString = song.fileURL, let audioURL = URL(string: audioString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
                            let playerItem = AVPlayerItem(url: audioURL)
                            self.player.replaceCurrentItem(with: playerItem)
                            self.player.play()
                        } else {
                            print("Wrong")
                            self.player.pause()
                        }
                    } else {
                        self.player.pause()
                    }
                }) {
                    ZStack{
                        Circle()
                            .frame(width: 50,height: 50)
                            .accentColor(Color("LightGreen"))
                            .shadow(radius: 10)
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(Color("DeepGreen"))
                            .font(.system(.title2))
                            .rotationEffect(.degrees(90))
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
                            .rotationEffect(.degrees(90))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: 200)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StyleTransfer()
    }
}
