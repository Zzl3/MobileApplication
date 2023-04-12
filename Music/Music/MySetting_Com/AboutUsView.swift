//
//  AboutUsView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct AboutUsView: View {
    @EnvironmentObject var appSettings: AppSettings
    var body: some View {
        
        
        Text("关于我们")
        
        Spacer()
        
    }
}



struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView().environmentObject(AppSettings())
    }
}
