//
//  MyARView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/17.
//

import RealityKit
import SwiftUI
struct SceneKitView: View {
    var body: some View{
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable{
    func makeUIView(context: Context) -> some ARView {
        let arView=ARView(frame: .zero)
        let mymodelAnchor=try! MyScene.loadBox() // 这里修改
        arView.scene.anchors.append(mymodelAnchor)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // not used
    }
}

struct SceneKitView_Previews: PreviewProvider {
    static var previews: some View {
        SceneKitView()
    }
}
