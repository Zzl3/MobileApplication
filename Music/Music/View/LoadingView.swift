//
//  LoadingView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Please wait...")
                .font(.title)
                .padding(.bottom, 20)
                .foregroundColor(.primary)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}
