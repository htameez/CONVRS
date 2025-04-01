//
//  CONVRSApp.swift
//  CONVRS
//
//  Created by Hamna Tameez on 2/22/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct CONVRSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authService = AuthService()

    init() {
        #if targetEnvironment(simulator)
        UserDefaults.standard.set(true, forKey: "FIRDebugEnabled")
        #endif

        FirebaseApp.configure()

        #if DEBUG
        // Sign out user on every launch during development
        try? Auth.auth().signOut()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            if authService.isLoading {
                ProgressView()
            } else {
                if authService.user != nil {
                    RootView().environmentObject(authService)
                } else {
                    Onboarding().environmentObject(authService)
                }
            }
        }
    }
}

