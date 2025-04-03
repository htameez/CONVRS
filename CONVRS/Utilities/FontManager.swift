//
//  FontManager.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct FontManager {
    enum Poppins: String {
        case regular = "Poppins-Regular"
        case bold = "Poppins-Bold"
    }

    enum Lato: String {
        case regular = "Lato-Regular"
    }

    static func poppins(_ weight: Poppins, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size)
    }

    static func lato(_ weight: Lato, size: CGFloat) -> Font {
        .custom(weight.rawValue, size: size)
    }
}
