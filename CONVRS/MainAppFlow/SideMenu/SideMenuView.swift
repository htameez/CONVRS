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
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.theme.blue)
                    .frame(width: 270)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(SideMenuRowType.allCases, id: \.self) { row in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedSideMenuTab = row.rawValue
                                presentSideMenu.toggle()
                            }
                        }) {
                            Text(row.title)
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.purple)
                                .padding(.leading, 20)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 100)
            }
            Spacer()
        }
        .background(Color.clear)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(true))
    }
}
