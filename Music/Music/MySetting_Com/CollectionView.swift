//
//  CollectionView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct CollectionView: View {
    @EnvironmentObject var appSettings: AppSettings
    var body: some View {
        
        Text("我的收藏")
        
        Spacer()
    }
}



struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView().environmentObject(AppSettings())
    }
}
