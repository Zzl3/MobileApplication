//
//  Intro_tool.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/10.
//

import UIKit


// 可以全局使用获取图像方法
extension UIImage {
    static func fetchImage(from urlString: String) -> UIImage {
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(systemName: "photo") ?? UIImage()
        }
        return image
    }
}


//extension UIImage {
//    static func fetchImage(from urlString: String) -> UIImage {
//        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//            let url = URL(string: encodedString)
//        }
//        guard let url = URL(string: urlString) else {
//            return UIImage(systemName: "photo") ?? UIImage()
//        }
//        guard let data = try? Data(contentsOf: url) else {
//            return UIImage(systemName: "photo") ?? UIImage()
//        }
//        return UIImage(data: data) ?? UIImage()
//    }
//}

