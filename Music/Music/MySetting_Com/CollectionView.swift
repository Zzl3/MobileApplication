//
//  CollectionView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct CollectionView: View {
    @Binding var showCollection : Bool
    var body: some View {
        
        Button{
            withAnimation(.easeInOut(duration: 0.35)){
                showCollection=false
            }
        } label: {
            Label("返回",systemImage: "arrowshape.turn.up.backward")
                .font(.title2)
                .foregroundColor(.black)
                .padding(15)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        
        Text("我的收藏")
        
        Spacer()
    }
}



struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(showCollection: .constant(false))
    }
}
