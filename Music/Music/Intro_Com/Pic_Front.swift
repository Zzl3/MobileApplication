//
//  Sheng_Front.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/19.
//

import SwiftUI
import AVKit

struct Pic_Front: View {
    var instrument:Instrument
    @State private var isPlaying = false
    let player = AVPlayer()
    
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .frame(width: 250)
                    .position(x:180,y:200)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.88))
                    .shadow(color: .gray, radius: 4, x: -2, y: 1)
                Image(uiImage: UIImage.fetchImage(from: instrument.image))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .position(x:190,y:165)
            }
            Image(uiImage: UIImage.fetchImage(from: instrument.nameImage))
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .position(x:190,y:250)
            Button(action: {
                self.isPlaying.toggle()
                if self.isPlaying {
                    if let audioString = instrument.audio, let audioURL = URL(string: audioString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
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
                Image(systemName: isPlaying ? "pause.circle" : "play.circle")
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.034, brightness: 0.782)/*@END_MENU_TOKEN@*/)
            .scaleEffect(4)
            .position(x:195,y:180)
        }
    }
}

struct Pic_Front_Previews: PreviewProvider {
    static var previews: some View {
        Introduction()
    }
}





