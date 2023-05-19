//
//  TempLoading.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/26.
//

import SwiftUI

struct TempLoading: View {
    @State private var isLoading = true
    var body: some View {
        
        VStack {
            if isLoading {
                Spacer()
                ProgressView() // 显示一个默认样式的加载指示器
                    .position(x:200,y:150)
                Text("正在为您转换中...") // 显示加载文本
                    .position(x:200,y:160)
            } else {
                NewDetailView()
            }
        }
        .onAppear {
            // Simulate loading delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                // Set isLoading to false after 2 seconds
                self.isLoading = false
            }
        }
    }
}

struct TempLoading_Previews: PreviewProvider {
    static var previews: some View {
        TempLoading()
    }
}
