//
//  TestView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct TestView: View {
    
    var body: some View {
        ZStack{
            Image("Background")
                .opacity(0.3)
        }
    }
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()//.environmentObject(UserStore())
    }
}
