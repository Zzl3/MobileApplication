//
//  TranChoice.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/3.
//

import SwiftUI

struct TranChoice: View {
    var body: some View {
        VStack{
            Image("testpic")
                .frame(height: 300)
            InstruChoice()
        }
        .padding(.bottom, 100.0)
        .padding(.top,40.0)
    }
       
}

struct TranChoice_Previews: PreviewProvider {
    static var previews: some View {
        TranChoice()
    }
}
