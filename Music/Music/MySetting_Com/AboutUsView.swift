//
//  AboutUsView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct AboutUsView: View {
    @Binding var showAboutUs : Bool
    var body: some View {
        
        Button{
            withAnimation(.easeInOut(duration: 0.35)){
                showAboutUs=false
            }
        } label: {
            Label("返回",systemImage: "arrowshape.turn.up.backward")
                .font(.title2)
                .foregroundColor(.black)
                .padding(15)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        
        Text("关于我们")
        
        Spacer()
        
    }
}



struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView(showAboutUs: .constant(false))
    }
}
