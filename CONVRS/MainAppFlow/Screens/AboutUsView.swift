//
//  AboutUsView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

// MARK: - StatusBarStyle Modifier
struct StatusBarStyleModifier: ViewModifier {
    var style: UIStatusBarStyle

    func body(content: Content) -> some View {
        content
            .background(StatusBarStyleViewController(style: style))
    }

    private struct StatusBarStyleViewController: UIViewControllerRepresentable {
        var style: UIStatusBarStyle

        func makeUIViewController(context: Context) -> UIViewController {
            let controller = UIViewController()
            controller.view.backgroundColor = .clear
            controller.overrideUserInterfaceStyle = style == .lightContent ? .dark : .light
            return controller
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
}

extension View {
    func statusBarStyle(_ style: UIStatusBarStyle) -> some View {
        self.modifier(StatusBarStyleModifier(style: style))
    }
}

// MARK: - Profile Model
struct Profile: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var bio: String
    var imageName: String
}

let profiles = [
    Profile(name: "Marissa Menjarez", location: "Dallas, TX", bio: "Computer Engineering, Computer Science & Data Analytics\nTraveled to Europe, Mexico, and 10/50 states\nInterned as an educational engagement engineer", imageName: "marissa"),
    Profile(name: "Emilio Munoz", location: "San Antonio, TX", bio: "Computer Science & Data Science\nBaptized in the Vatican\nBuilt a SuperSonic Rocket", imageName: "emilio"),
    Profile(name: "Hamna Tameez", location: "Memphis, TN", bio: "Computer Science\nWent to an international school for a year\nFocus on Software Engineering", imageName: "hamna")
]

// MARK: - ProfileCard View
struct ProfileCardView: View {
    var profile: Profile

    var body: some View {
        VStack(spacing: 12) {
            Image(profile.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 240, height: 317)
                .clipped()
                .padding(.top, 10)

            Text(profile.name)
                .font(FontManager.poppins(.bold, size: 36))
                .foregroundColor(.white)

            Text(profile.location)
                .font(FontManager.lato(.regular, size: 18))
                .foregroundColor(.white)

            Text(profile.bio)
                .font(FontManager.lato(.regular, size: 13))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.vertical, 20)
        .frame(maxHeight: .infinity)
    }
}

// MARK: - About Us View
struct AboutUsView: View {
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            Color.theme.darkPurple
                .ignoresSafeArea()

            VStack {
                Spacer()

                ProfileCardView(profile: profiles[currentIndex])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .animation(.easeInOut, value: currentIndex)

                Spacer()

                HStack(spacing: 8) {
                    ForEach(0..<profiles.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? Color.white : Color.white.opacity(0.4))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.bottom, 30)

                Button(action: {
                    currentIndex = (currentIndex + 1) % profiles.count
                }) {
                    ZStack {
                        Image("arrow")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .opacity(currentIndex < profiles.count - 1 ? 1 : 0)
                            .animation(.easeInOut(duration: 0.3), value: currentIndex)

                        Image("arrow")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .rotationEffect(.degrees(180))
                            .opacity(currentIndex == profiles.count - 1 ? 1 : 0)
                            .animation(.easeInOut(duration: 0.3), value: currentIndex)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .statusBarStyle(.lightContent)
        .preferredColorScheme(.dark) // 👈 Force About Us screen to be light always
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
