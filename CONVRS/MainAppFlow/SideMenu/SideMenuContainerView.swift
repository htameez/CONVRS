//
//  SideMenuContainerView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct SideMenuContainerView: View {
    @State private var isMenuOpen = false
    @State private var selectedScreen = "Home"

    var body: some View {
        ZStack {
            // Main Content (Home, About Us, Settings)
            NavigationStack {
                Group {
                    if selectedScreen == "Home" {
                        HomeView()
                    } else if selectedScreen == "AboutUs" {
                        AboutUsView()
                    } else if selectedScreen == "Settings" {
                        SettingsView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isMenuOpen.toggle()
                            }
                        }) {
                            Image("menu_icon")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .offset(x: isMenuOpen ? UIScreen.main.bounds.width / 2 : 0) // Shift content when menu is open
            .overlay(
                isMenuOpen ?
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { withAnimation { isMenuOpen.toggle() } }
                : nil
            )
            .animation(.easeInOut(duration: 0.3), value: isMenuOpen)

            // Side Menu
            SideMenuView(isMenuOpen: $isMenuOpen, selectedScreen: $selectedScreen)
                .offset(x: isMenuOpen ? 0 : -UIScreen.main.bounds.width / 2) // Fully off-screen when closed
                .animation(.easeInOut(duration: 0.3), value: isMenuOpen)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct SideMenuContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuContainerView()
    }
}

