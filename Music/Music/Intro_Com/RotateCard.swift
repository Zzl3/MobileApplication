//
//  RotateCard.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/19.
//

import SwiftUI
struct FlipEffect: GeometryEffect {
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    @Binding var flipped: Bool  // 绑定卡片当前的状态
    var angle: Double  // 翻转角度变量
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle<270// 根据当前的角度改变 flipped 的值
        }
        let a = CGFloat(Angle.degrees(angle).radians)
        var transform3d = CATransform3DIdentity
        transform3d = CATransform3DRotate(transform3d, a, 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height/2.0))
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
    
}

struct RotateCard: View,Identifiable {
    var id: UUID = UUID()
    @State var flipped: Bool = false
    @State var trigger: Bool = false
    var instrument:Instrument
    
    var body: some View {
            VStack {
                if (flipped) {
                    Pic_Intro(instrument:(instrument))
                    .scaleEffect(0.8)
                    .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                }
                else {
                    Pic_Front(instrument:(instrument))
                    .scaleEffect(0.8)
                }
            }
            .background()
            .cornerRadius(25)
            .shadow(color: Color(.displayP3, red: 0, green: 0.0, blue: 0.264, opacity: 0.4), radius: 16, x: 0, y: 16)
            .modifier(FlipEffect(flipped: $flipped ,angle: trigger ? 180: 0))
            .onTapGesture  {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                    self.trigger.toggle()
                }
            }
        }

}

struct RotateCard_Previews: PreviewProvider {
    static var previews: some View {
        RotateCard(instrument:sampleInstrument[0] )
    }
}
