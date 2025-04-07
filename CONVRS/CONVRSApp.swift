//
//  CONVRSApp.swift
//  CONVRS
//
//  Created by Hamna Tameez on 2/22/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

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
    @AppStorage("appTheme") var appTheme = "Light"  // <-- your theme storage

    init() {
        #if targetEnvironment(simulator)
        UserDefaults.standard.set(true, forKey: "FIRDebugEnabled")
        #endif

        FirebaseApp.configure()

        #if DEBUG
        try? Auth.auth().signOut()
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        #endif
    }

    var body: some Scene {
        WindowGroup {
            let colorScheme: ColorScheme? = appTheme == "Dark" ? .dark : .light  // <-- here's your line

            if authService.isLoading {
                ProgressView()
                    .preferredColorScheme(colorScheme)
            } else {
                if authService.user != nil {
                    RootView()
                        .environmentObject(authService)
                        .preferredColorScheme(colorScheme) // <- applied here
                } else {
                    Onboarding()
                        .environmentObject(authService)
                        .preferredColorScheme(colorScheme) // <- also applied here
                }
            }
        }
    }
}
