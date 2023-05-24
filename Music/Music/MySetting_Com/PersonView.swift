//
//  PersonView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import SwiftUI
import SceneKit


struct PersonView: View {
    //这个就是触发跳转的布尔值
    @State private var isShowingDetailView = false
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject  var appSettings: AppSettings
    @State var scene: SCNScene? = .init(named:"1.scn")
    @GestureState var offset:CGFloat = 0
    var body: some View {
        NavigationView {
            ZStack{
//                Image("Background")
//                    .opacity(0.3)
                VStack {
//                    NavigationLink(destination:  SceneKitView(), isActive: $isShowingDetailView) { EmptyView()}
                    
                    CustomARView(scene: scene)
//                        .frame(height: 400)
                        .padding(.bottom,3)
                    CustomSeeker()
                    
//                    Button(action: {
//                        isShowingDetailView = true
//                    }, label: {
//                        Text("VR现实")
//                    })
//                    .padding()
//                    .background(Color("DeepGreen"))
//                    .foregroundColor(.white)
//                    .cornerRadius(10)

                }
            }
      
        }
    }
    
    @ViewBuilder
    func CustomSeeker()->some View{
        GeometryReader{_ in
            Rectangle()
                .trim(from: 0,to:0.474)
                .stroke(.linearGradient(colors:[
                    .clear,
                    .clear,
                    .green.opacity(0.2),
                    .green.opacity(0.6),
                    .green,
                    .green.opacity(0.6),
                    .green.opacity(0.2),
                    .clear,
                    .clear
                ], startPoint: .leading, endPoint: .trailing),style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round,miterLimit: 1,dash: [3],dashPhase: 1))
                .offset(x:offset)
                .overlay{
                    HStack(spacing:3){
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.caption)
                            .foregroundColor(.white)
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal,7)
                    .padding(.vertical,10)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("DeepGreen"))
                    }
                    .offset(y:-13)
                    .offset(x:offset)
                    .gesture(
                        DragGesture()
                            .updating($offset, body: {value,out, _ in
                                out = value.location.x - 20
                                
                            }))
                }
            
        }
        .frame(height: 20)
        .onChange(of: offset, perform: {newValue in
            rotateObject()
        })
        .animation(.easeInOut(duration: 0.4), value: offset == .zero)
    }
    
    //MARK: Rotating 3D Object
    func rotateObject(){
        let newAngle = Float((offset * .pi) / 100)
        scene?.rootNode.eulerAngles.y=newAngle
    }
}


struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        //MySetting()
//        PersonView().environmentObject(AppSettings())
        PersonView()
    }
}
