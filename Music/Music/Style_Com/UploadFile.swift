//
//  UploadFile.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/26.
//

import SwiftUI
import AVKit

struct AudioRecorderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isRecording = false
    @Binding var audioURL: URL?
    @State var showText=false
    
    var body: some View {
        ZStack{
            Image("voicebg")
                .scaleEffect(0.5)
                .opacity(0.5)
                .layoutPriority(-1)
            
            VStack {
                // Display recording button
                Button(action: {
                    if isRecording {
                        stopRecording()
                    } else {
                        startRecording()
                    }
                    isRecording.toggle()
                }) {
                    Image(systemName: isRecording ? "stop.circle" : "circle")
                        .font(.system(size: 64))
                        .foregroundColor(.red)
                }
               
                // Display audio visualization
                AudioVisualization(isRecording: isRecording)
                    .frame(height: 80)
                
                // Display cancel and save buttons
                HStack {
                    Button("取消录制") {
                        audioURL = nil
                        startTime = nil
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .foregroundColor(.primary)
                    .font(.custom("Slideqiuhong",size:20))
                    
                    Spacer()
                    
                    Button("保存音频") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .disabled(audioURL == nil)
                    .foregroundColor(.primary)
                    .font(.custom("Slideqiuhong",size:20))
                }
                
                if(showText){
                    // Display recording time
                    Text("已录制\(recordingTime, specifier: "%.2f") 秒")
                        .font(.custom("Slideqiuhong",size:20))
                        .font(.headline)
                        .padding()
                        .foregroundColor(.primary)
                        
                }
            }
        }
       
    }
    
    // Recording timer
    @State private var startTime: Date?
    var recordingTime: TimeInterval {
        startTime.map { -$0.timeIntervalSinceNow } ?? 0
    }
    
    func startRecording() {
        // Define the recording settings
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            // Create an instance of AVAudioRecorder
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let audioURL = getDocumentsDirectory().appendingPathComponent("recording.m4a")
            let audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            
            // Start recording
            audioRecorder.record()
            self.audioURL = audioURL
            startTime = Date()
            print(startTime)
        } catch let error {
            print("Error recording audio: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        // Stop recording
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(false)
        showText=true
//        audioURL = nil
//        startTime = nil
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct AudioVisualization: View {
    let isRecording: Bool
    var body: some View {
        ZStack {
            if isRecording {
                // Display audio visualization when recording
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("DeepGreen"))
                    .frame(width: 20, height: 40)
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("DeepGreen"))
                    .frame(width: 20, height: 60)
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("DeepGreen"))
                    .frame(width: 20, height: 80)
            } else {
                // Display audio visualization when not recording
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("LightGreen"))
                    .frame(width: 20, height: 20)
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("LightGreen"))
                    .frame(width: 20, height: 40)
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("LightGreen"))
                    .frame(width: 20, height: 60)
            }
        }
    }
}


class AudioPlayer:NSObject,ObservableObject {
    @Published var player: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0

    func load(url: URL) {
        print(url)
        //确定文件可读
        do {
            let file = try AVAudioFile(forReading: url)
            // 加载音频文件
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }

        
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
    @State private var showAudioRecorder = false
     
     var body: some View {
         VStack{
             ZStack{
                 Image("huawen2")
                     .opacity(0.4)
                     .scaleEffect(0.07)
                 VStack {
                     if audioURL != nil {
                         Text("已经加载: \(audioURL!.lastPathComponent)")
                             .font(.custom("Slideqiuhong",size:20))
                             .foregroundColor(Color.black)
                     }
                     HStack{
                         Button(action: {
                             showFileChooser = true
                         }) {
                             Text("上传音频")
                                 .font(.custom("Slideqiuhong",size:20))
                                 .padding()
                                 .background(Color("DeepGreen"))
                                 .foregroundColor(.primary)
                                 .cornerRadius(8)
                         }
                         
                         Button(action: {
                             showAudioRecorder = true
                         }) {
                             Text("录制音频")
                                 .font(.custom("Slideqiuhong",size:20))
                                 .padding()
                                 .background(Color("DeepGreen"))
                                 .foregroundColor(.primary)
                                 .cornerRadius(8)
                         }
                         
                         Button("开始转换") {
                             showLoading = true
                         }
                         .padding()
                         .font(.custom("Slideqiuhong",size:20))
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
                         .frame(width: 350)
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
                 .sheet(isPresented: $showAudioRecorder) {
                     AudioRecorderView(audioURL: $audioURL)
                         .onDisappear {
                             if let url = audioURL {
                                 print("下面是获得的文件")
                                 print(url)
                                 audioPlayer.load(url: url)
                             }
                         }
                 }
                 
                 .sheet(isPresented: $showFileChooser) {
                     FileChooser(audioURL: $audioURL)
                         .onDisappear {
                             if let url = audioURL {
                                 print("下面是获得的文件")
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
                        .font(.custom("Slideqiuhong",size:40))
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
