//
//  Color.swift
//  Music
//
//  Created by sihhd on 2023/4/12.
//


//定义深浅色
import Foundation
import SwiftUI

public extension Color {

    static let textColor = Color("DeepGreen")
    
}

class AppSetting: ObservableObject {
    @Published var darkModeSettings: Int = UserDefaults.standard.integer(forKey: "darkMode") {
        didSet {
            UserDefaults.standard.set(self.darkModeSettings, forKey: "darkMode")
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            switch self.darkModeSettings {
            case 0:
                window?.overrideUserInterfaceStyle = .unspecified
            case 1:
                window?.overrideUserInterfaceStyle = .light
            case 2:
                window?.overrideUserInterfaceStyle = .dark
            default:
                window?.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}
