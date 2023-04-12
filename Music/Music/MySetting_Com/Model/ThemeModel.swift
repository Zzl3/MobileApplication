//
//  ThemeModel.swift
//  Music
//
//  Created by sihhd on 2023/4/12.
//

import SwiftUI

//MARK: - Dark Model
struct MyDarkModel: Identifiable {
  let id: Int
  let image: String
  let name: String
}

//MARK: - Accent Color
struct MyAccentColor: Identifiable {
  let id: Int
  let name: String
  let color: Color
}

