//
//  PersonView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct ReplyView: View {
    
    var body: some View {
        ZStack {
            TitleView()
        }
    }
}



struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("反馈答复\n消息通知\n其他")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}

struct ReplyView_Previews: PreviewProvider {
    static var previews: some View {
        ReplyView()//.environmentObject(UserStore())
    }
}

