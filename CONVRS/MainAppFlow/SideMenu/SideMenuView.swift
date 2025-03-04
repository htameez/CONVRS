//
//  SideMenuView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isMenuOpen: Bool
    @Binding var selectedScreen: String

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3") // Close menu icon
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.top, 40)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                MenuItem(title: "About Us") {
                    selectedScreen = "AboutUs"
                    isMenuOpen.toggle()
                }
                MenuItem(title: "Settings") {
                    selectedScreen = "Settings"
                    isMenuOpen.toggle()
                }
                MenuItem(title: "Sign Out") {
                    print("Sign Out Logic") // Implement sign-out action
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding(.leading, 20)
        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
        .background(Color.theme.blue) // Adjusted to match screenshot
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuItem: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.theme.purple)
        }
    }
}
