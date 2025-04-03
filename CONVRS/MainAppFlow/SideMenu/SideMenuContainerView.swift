//
//  SideMenuContainerView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct SideMenuContainerView: View {
    @Binding var isShowing: Bool
    @Binding var selectedSideMenuTab: Int
    
    var body: some View {
<<<<<<< HEAD
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
=======
        ZStack(alignment: .leading) {
            if isShowing {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isShowing.toggle()
                        }
                    }
                
                SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $isShowing)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShowing)
>>>>>>> Hamna
    }
}
