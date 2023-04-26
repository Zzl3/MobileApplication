//
//  UploadFile.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/26.
//

import SwiftUI
import AVKit

class AudioPlayer:NSObject,ObservableObject {
    @Published var player: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0

    func load(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            player = try AVAudioPlayer(data: data)
            player?.delegate = self
            player?.prepareToPlay()
        } catch {
            print("Error loading audio file: \(error)")
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func seek(to time: TimeInterval) {
        player?.currentTime = time
        currentTime = time
    }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        currentTime = 0
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio player decode error: \(String(describing: error))")
    }
}

struct FileChooser: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var audioURL: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: FileChooser
        
        init(_ parent: FileChooser) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.audioURL = urls.first
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct UploadFile: View {
    @State private var audioURL: URL?
    @State private var showFileChooser = false
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @State var currentIndex:Int=0
    @State var currentTab:InstruTab=tabs[0]
    @Namespace var animation
    
    var song:Song
    @State var selectedInstru:Album?
    @State private var showLoading = false
     
     var body: some View {
         VStack{
             ZStack{
                 Image("huawen2")
                     .opacity(0.4)
                     .scaleEffect(0.07)
                 VStack {
                     if audioURL != nil {
                         Text("Loaded: \(audioURL!.lastPathComponent)")
                     }
                     HStack{
                         Button(action: {
                             showFileChooser = true
                         }) {
                             Text("上传音频文件")
                                 .padding()
                                 .background(Color("DeepGreen"))
                                 .foregroundColor(.primary)
                                 .cornerRadius(8)
                         }
                         
                         Button("开始转换音频") {
                             showLoading = true
                         }
                         .padding()
                         .background(Color("DeepGreen"))
                         .foregroundColor(.primary)
                         .cornerRadius(8)
                         
                         // Use NavigationLink to navigate to detail view
                         NavigationLink(destination: TempLoading(), isActive: $showLoading) {
                             EmptyView()
                         }
                     }

                     
                     VStack {
                         HStack {
                             Text("0:00")
                             Spacer()
                             Text("\(Int(audioPlayer.player?.duration ?? 0))")
                         }
                         Slider(value: $audioPlayer.currentTime, in: 0.0...(audioPlayer.player?.duration ?? 0.0), onEditingChanged: { _ in
                             audioPlayer.seek(to: audioPlayer.currentTime)
                         })
                         .frame(width: 300)
                     }
                     .padding()
                     HStack {
                         Button(action: {
                             audioPlayer.isPlaying ? audioPlayer.pause() : audioPlayer.play()
                         }) {
                             Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                                 .font(.system(size: 24))
                                 .foregroundColor(Color("DeepGreen"))
                         }
                     }
                 }
                 .sheet(isPresented: $showFileChooser) {
                     FileChooser(audioURL: $audioURL)
                         .onDisappear {
                             if let url = audioURL {
                                 audioPlayer.load(url: url)
                             }
                         }
                 }
                 .padding()
             }
             .frame(maxHeight: 300)
            
             
             GeometryReader{proxy in
                 let size = proxy.size
                 CarouselView(size: size)
             }
             .padding(.bottom,130)
             .padding(.top,-130)
         }

     }
    
    @ViewBuilder
    func CarouselView(size:CGSize)->some View{
        VStack(spacing:-40){
            CustomCarousel(index:$currentIndex, items: sampleAlbums,spacing: 10,cardPadding: size.width / 2 ,id: \.id){
                sampleAlbums,size in
                VStack(spacing:10){
                    ZStack{
                        if selectedInstru?.id == sampleAlbums.id{
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
                        .foregroundColor(.primary)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.8)){
                        selectedInstru = sampleAlbums //被选中的乐器
                    }
                }
            }
            .frame(height: size.height * 0.8)
            Indicators()
        }
        .frame(width: size.width,height: size.height,alignment: .bottom)
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

struct UploadFile_Previews: PreviewProvider {
    static var previews: some View {
        UploadFile(song:sampleSong[0])
    }
}
