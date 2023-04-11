//
//  MySetting.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI

struct MySetting: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: FeedBack()) {
                Text("提交反馈")
            }
            .navigationTitle("我的设置")
        }
        
    }
}

struct MySetting_Previews: PreviewProvider {
    static var previews: some View {
        MySetting()
    }
}
