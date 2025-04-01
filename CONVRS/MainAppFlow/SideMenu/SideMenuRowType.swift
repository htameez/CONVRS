//
//  SideMenuRowType.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/6/25.
//

import SwiftUI

enum SideMenuRowType: Int, CaseIterable {
    case home = 0
    case aboutus
    case settings
    case signout
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .aboutus:
            return "About Us"
        case .settings:
            return "Settings"
        case .signout:
            return "Sign Out"
        }
    }
}
