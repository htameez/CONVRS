//
//  CONVRSApp.swift
//  CONVRS
//
//  Created by Hamna Tameez on 2/22/25.
//

import SwiftUI
import Firebase

@main
struct CONVRSApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            Onboarding() // Start with onboarding, which handles login check
        }
    }
}
