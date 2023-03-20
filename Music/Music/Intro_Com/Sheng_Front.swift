//
//  Sheng_Front.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/19.
//

import SwiftUI

struct Sheng_Front: View {
    var body: some View {
        VStack{
            Image("ShengP")
                .scaleEffect(0.8)
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
                .position(x:175,y:140)
            
            Image("ShengT")
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
                .position(x:190,y:335)
                .scaleEffect(0.6)
            
            Image(systemName: "play.circle")
                .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.034, brightness: 0.782)/*@END_MENU_TOKEN@*/)
                .scaleEffect(4)
                .position(x:195,y:180)
        }
    }
}

struct Sheng_Front_Previews: PreviewProvider {
    static var previews: some View {
        Sheng_Front()
    }
}
