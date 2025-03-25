//
//  RootView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct RootView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    selectedView()
                        .navigationBarTitle(currentTitle(), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            withAnimation {
                                presentSideMenu.toggle()
                            }
                        }) {
                            Image("menu_icon")
                                .resizable()
                                .frame(width: 24, height: 24)
                        })
                }
            }
            
            SideMenuContainerView(isShowing: $presentSideMenu, selectedSideMenuTab: $selectedSideMenuTab)
        }
    }
    
    @ViewBuilder
    func selectedView() -> some View {
        switch selectedSideMenuTab {
        case 0:
            HomeView()
        case 1:
            AboutUsView()
        case 2:
            SettingsView()
        default:
            HomeView()
        }
    }
    
    func currentTitle() -> String {
        switch selectedSideMenuTab {
        case 0:
            return "Home"
        case 1:
            return "About Us"
        case 2:
            return "Settings"
        default:
            return "CONVRS"
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

