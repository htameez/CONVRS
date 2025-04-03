//
//  LightStatusBarHostingController.swift
//  CONVRS
//
//  Created by Hamna Tameez on 4/1/25.
//

import SwiftUI

class LightStatusBarHostingController<Content>: UIHostingController<Content> where Content: View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

struct RootHostingController<Content: View>: UIViewControllerRepresentable {
    var content: () -> Content

    func makeUIViewController(context: Context) -> UIViewController {
        LightStatusBarHostingController(rootView: content())
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
