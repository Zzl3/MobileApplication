//
//  ContentView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI

struct Introduction: View {
    @State var cards:[RotateCard]=[
        .init(TypeInstru: "Sheng"),
        .init(TypeInstru: "Sheng")]
    var body: some View {
        VStack{
            Intro_Nav()
            Spacer(minLength: 30)
            CardsScrollView()
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.945, green: 0.949, blue: 0.949)/*@END_MENU_TOKEN@*/)
    }
    
    @ViewBuilder
    func CardsScrollView()->some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:15){
                RotateCard(TypeInstru: "Sheng")
                    .scaleEffect(0.95)
                Spacer(minLength: 25)
                RotateCard(TypeInstru: "Sheng")
                Spacer(minLength: 25)
                RotateCard(TypeInstru: "Sheng")
            }
            .foregroundColor(Color(red: 0.949, green: 0.949, blue: 0.949))
            .padding(.leading,20)
        }
    }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        Introduction()
    }
}
