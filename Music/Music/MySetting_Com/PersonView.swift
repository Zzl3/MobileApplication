//
//  PersonView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct PersonView: View {
    
    var body: some View {
        ScrollView {
            ZStack {
                
                VStack {
                    HStack(spacing: 12) {
                        Text("个人主页")
                            .font(.system(size: 28, weight: .bold))
                            
                        
                        Spacer()
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)
                    
                    Text("personal page")
                }
            }
            
            
        }
        .background(Image("testpic")
            .resizable()
            //.frame(width: .infinity)
            .opacity(0.05)
        )
        
    }
}



struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()//.environmentObject(UserStore())
    }
}
