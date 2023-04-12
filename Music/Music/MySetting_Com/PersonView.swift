//
//  PersonView.swift
//  Music
//
//  Created by sihhd on 2023/4/11.
//

import Foundation
import SwiftUI


struct PersonView: View {
    
    @Environment(\.presentationMode)    var presentationMode
    @EnvironmentObject                  var appSettings: AppSettings
    
    var body: some View {
        Text("personal page")
        .accentColor(accentColorData[self.appSettings.accentColorSettings].color)
    }
}




struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView().environmentObject(AppSettings())
    }
}
