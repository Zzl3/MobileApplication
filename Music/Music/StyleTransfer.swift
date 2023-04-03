//
//  StyleTransfer.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI

struct StyleTransfer: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination:
               TranChoice()){Text("跳转")
                    .foregroundColor(.black)
            }
                .navigationTitle("歌曲列表")
        }
    }
}

struct StyleTransfer_Previews: PreviewProvider {
    static var previews: some View {
        StyleTransfer()
    }
}
