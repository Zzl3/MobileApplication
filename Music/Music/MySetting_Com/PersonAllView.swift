//
//  PersonAllView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/5/23.
//

import SwiftUI
import SceneKit

struct PersonAllView: View {
    // current index
    @State var currentIndex: Int = 0
//    @State var scene: SCNScene? = .init(named:"1.scn")
//    @GestureState var offset:CGFloat = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(posts.indices, id: \.self) { index in
                    GeometryReader { proxy in
                        Image(posts[index].postImg)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .cornerRadius(1)
                    }
                    .ignoresSafeArea()
                    .offset(y: -100)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            .overlay(
                LinearGradient(colors: [
                    Color.clear,
                    Color.black.opacity(0.2),
                    Color.white.opacity(0.4),
                    Color.white,
                    Color.white,
                    Color.white,
                ], startPoint: .top, endPoint: .bottom)
            )
            .ignoresSafeArea()
            
            //posts..
            SnapCarousel(trailingSpace: getRect().height < 750 ? 100 : 150 ,index: $currentIndex, items: posts) { post in
                CardView(post: post)
            }
            .offset(y: getRect().height / 4)
        }
        
    }
    
    @ViewBuilder
    func CardView(post: Post) -> some View {
        VStack(spacing: 10) {
            GeometryReader { proxy in
                Image(post.postImg)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .cornerRadius(25)
//                CustomARView(scene: $scene)
//                    .frame(height: 400)
//                    .padding(.bottom,30)
//                CustomSeeker()
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(25)
            .frame(height: getRect().height / 2.5)
            .padding(.bottom, 15)
            Text(post.titile)
                .font(.title2.bold())
            .font(.caption)
            Text(post.description)
                .font(.callout)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.top , 8)
                .padding(.horizontal)
        }
    }
    
//    @ViewBuilder
//    func CustomSeeker()->some View{
//        GeometryReader{_ in
//            Rectangle()
//                .trim(from: 0,to:0.474)
//                .stroke(.linearGradient(colors:[
//                    .clear,
//                    .clear,
//                    .green.opacity(0.2),
//                    .green.opacity(0.6),
//                    .green,
//                    .green.opacity(0.6),
//                    .green.opacity(0.2),
//                    .clear,
//                    .clear
//                ], startPoint: .leading, endPoint: .trailing),style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round,miterLimit: 1,dash: [3],dashPhase: 1))
//                .offset(x:offset)
//                .overlay{
//                    HStack(spacing:3){
//                        Image(systemName: "arrowtriangle.left.fill")
//                            .font(.caption)
//                            .foregroundColor(.white)
//                        Image(systemName: "arrowtriangle.right.fill")
//                            .font(.caption)
//                            .foregroundColor(.white)
//                    }
//                    .foregroundColor(.black)
//                    .padding(.horizontal,7)
//                    .padding(.vertical,10)
//                    .background{
//                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .fill(Color("DeepGreen"))
//                    }
//                    .offset(y:-13)
//                    .offset(x:offset)
//                    .gesture(
//                        DragGesture()
//                            .updating($offset, body: {value,out, _ in
//                                out = value.location.x - 20
//
//                            }))
//                }
//
//        }
//        .frame(height: 20)
//        .onChange(of: offset, perform: {newValue in
//            rotateObject()
//        })
//        .animation(.easeInOut(duration: 0.4), value: offset == .zero)
//    }
//
//    //MARK: Rotating 3D Object
//    func rotateObject(){
//        let newAngle = Float((offset * .pi) / 100)
//        scene?.rootNode.eulerAngles.y=newAngle
//    }
}

struct PersonAllView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAllView()
    }
}


// screen bounds
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
