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
    }
}
