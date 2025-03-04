//
//  Color.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let blue = Color("BlueColor")
    let purple = Color("PurpleColor")
    let darkPurple = Color("DarkPurpleColor")
    let gray = Color("GrayColor")
}
