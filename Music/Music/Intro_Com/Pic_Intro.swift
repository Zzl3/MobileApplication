//
//  Sheng_Intro.swift
//  Music
//
//  Created by sihhd on 2023/3/24.
//

import SwiftUI


struct Pic_Intro : View{
    var instrument:Instrument
    var body :some View{
        VStack{
            Image(uiImage: UIImage.fetchImage(from: instrument.image))
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .position(x:180,y:140)
            
            Image(uiImage: UIImage.fetchImage(from: instrument.nameImage))
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .position(x :110,y : 110)
            
            Text(instrument.description)
                .font(.custom("Slideqiuhong",size:20))
                .foregroundColor(.black)
            
//            Image("ShengIntroText")
//                .scaleEffect(1)
//                .aspectRatio(contentMode: .fit)
//                .frame(width:350)
//                .position(x:182,y:135)
        }
        
    }
}
struct Pic_Intro_Previews:PreviewProvider{
     static var previews: some View {
         Introduction()
    }
}
