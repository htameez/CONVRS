//
//  FontManager.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct FontManager {
    static let customFont = "YourFontName"

    static func font(size: CGFloat) -> Font {
        .custom(customFont, size: size)
    }
}
