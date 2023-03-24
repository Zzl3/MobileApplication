//
//  Sheng_Intro.swift
//  Music
//
//  Created by sihhd on 2023/3/24.
//

import SwiftUI


struct Sheng_Intro : View{
    var body :some View{
        VStack{
            Image("ShengP")
                .scaleEffect(0.4)
                .aspectRatio(contentMode: .fit)
                .frame(width:350)
                .position(x:180,y:140)
            
            Image("ShengIntro")
                .scaleEffect(1.3)
                .aspectRatio(contentMode: .fit)
                .frame(width : 350)
                .position(x :110,y : 110)
            
            Image("ShengIntroText")
                .scaleEffect(1)
                .aspectRatio(contentMode: .fit)
                .frame(width:350)
                .position(x:182,y:135)
            
            Image("SystemReturn")
                .scaleEffect(1.1)
                .aspectRatio(contentMode: .fit)
                .frame(width:350)
                .position(x:180, y:140)
        }
        
    }
}
struct Sheng_Intro_Previews:PreviewProvider{
     static var previews: some View {
            Sheng_Intro()
    }
}
