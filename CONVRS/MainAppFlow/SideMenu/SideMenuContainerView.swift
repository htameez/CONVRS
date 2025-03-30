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
            // Side Menu View
            if isMenuOpen {
                SideMenuView(isMenuOpen: $isMenuOpen, selectedScreen: $selectedScreen)
                    .frame(width: 250)
                    .transition(.move(edge: .leading))
            }

            // Main content view
            mainContentView()
                .offset(x: isMenuOpen ? 250 : 0)
                .disabled(isMenuOpen)
        }
        .animation(.easeInOut, value: isMenuOpen)
    }

    private func mainContentView() -> some View {
        VStack(spacing: 0) {
            // Top bar
            HStack {
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .padding()
                }

                Spacer()

                Text(selectedScreen == "Home" ? "CONVRS" : selectedScreen)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: "line.horizontal.3")
                    .resizable()
                    .frame(width: 20, height: 15)
                    .opacity(0)
                    .padding()
            }

            // Display screen content
            Group {
                if selectedScreen == "Home" {
                    HomeView()
                } else if selectedScreen == "AboutUs" {
                    AboutUsView()
                } else if selectedScreen == "Settings" {
                    SettingsView()
                }
            }
        }
    }
}
