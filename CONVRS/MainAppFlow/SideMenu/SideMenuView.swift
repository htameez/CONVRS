//
//  SideMenuView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    @EnvironmentObject var authService: AuthService

    var body: some View {
        HStack {
            menuPanel
            Spacer()
        }
        .background(Color.clear)
    }

    private var menuPanel: some View {
        ZStack {
            Rectangle()
                .fill(Color.theme.blue)
                .frame(width: UIScreen.main.bounds.width / 2)
                .ignoresSafeArea(.all, edges: .vertical)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)

            menuOptions
                .padding(.top, 100)
        }
    }

    private var menuOptions: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(SideMenuRowType.allCases, id: \.self) { row in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if row == .signout {
                            authService.signOut()
                        } else {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                }) {
                    Text(row.title)
                        .font(FontManager.lato(.regular, size: 20))
                        .bold()
                        .foregroundColor(row == .signout ? .red : Color.theme.purple)
                }
            }
            Spacer()
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(true))
            .environmentObject(AuthService())
    }
}

