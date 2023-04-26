//
//  Playing.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/26.
//

import SwiftUI
import AVFoundation

struct Playing: View {
    var body: some View {
        AudioPlayerView(songName: "春江花月夜（笛子）")
    }
}

struct AudioPlayerView: View {
    // 音频播放器
    @State private var audioPlayer: AVAudioPlayer?
    // 歌曲文件名
    let songName: String
    
    var body: some View {
        VStack {
            Text("\(songName)") // 显示歌曲名称
                .foregroundColor(.primary)
            Button("播放") {
                // 播放歌曲
                playSong()
            }
            .disabled(audioPlayer != nil && audioPlayer!.isPlaying) // 禁用按钮如果歌曲正在播放
            Button("暂停") {
                // 停止歌曲
                stopSong()
            }
            .disabled(audioPlayer == nil || !audioPlayer!.isPlaying) // 禁用按钮如果没有歌曲在播放
        }
    }
    
    // 播放歌曲
    func playSong() {
        guard let url = Bundle.main.url(forResource: songName, withExtension: "mp3") else {
            print("Failed to load audio file")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to create audio player: \(error.localizedDescription)")
        }
    }
    
    // 停止歌曲
    func stopSong() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

struct Playing_Previews: PreviewProvider {
    static var previews: some View {
        Playing()
    }
}
