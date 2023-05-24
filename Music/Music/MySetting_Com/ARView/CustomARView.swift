//
//  CustomARView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/17.
//

import SwiftUI
import SceneKit

struct CustomARView: UIViewRepresentable {
    var scene: SCNScene?
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene=scene
        view.backgroundColor = .clear
        return view
    }
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
}

//struct CustomARView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomARView()
//    }
//}
