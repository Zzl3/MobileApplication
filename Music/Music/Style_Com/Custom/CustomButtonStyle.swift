//
//  CustomButtonStyle.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/10.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
//            .padding(20)
            .foregroundColor(.white)
            .background(Color("DeepGreen"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
    }
}
