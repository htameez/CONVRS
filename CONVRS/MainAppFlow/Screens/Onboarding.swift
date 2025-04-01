//
//  Onboarding.swift
//  CONVRS
//
//  Created by Istiaque Ahamed on 2/7/22.
//
//
//
//  Created by Istiaque Ahamed on 2/7/22.

import SwiftUI
import Firebase
import FirebaseAuth

struct Onboarding: View {
    @State private var maxCircleHeight: CGFloat = 0
    @State private var showSignUp = false
    @State private var userIsLoggedIn = false

    var body: some View {
        Group {
            if userIsLoggedIn {
                RootView()
            } else {
                loginSignupPage
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { _, user in
                if user != nil {
                    userIsLoggedIn = true
                }
            }
        }
    }

    var loginSignupPage: some View {
        VStack(spacing: 0) {
            // Top Decorative Circles
            GeometryReader { proxy in
                let height = proxy.frame(in: .global).height

                ZStack {
                    Circle()
                        .fill(Color("orange"))
                        .offset(x: getRect().width / 2, y: -height / 1.0)

                    Circle()
                        .fill(Color("orange"))
                        .offset(x: -getRect().width / 2, y: -height / 1.8)

                    Circle()
                        .fill(Color("gray"))
                        .offset(y: -height / 1.3)
                        .rotationEffect(.degrees(-5))
                }
                .onAppear {
                    if maxCircleHeight == 0 {
                        maxCircleHeight = height
                    }
                }
            }
            .frame(maxHeight: getRect().width)

            // Login or Signup View
            ZStack {
                if showSignUp {
                    SignUp()
                        .transition(.move(edge: .leading))
                } else {
                    Login()
                        .transition(.move(edge: .leading))
                }
            }
            .padding(.top, -maxCircleHeight / (getRect().height < 750 ? 1.5 : 1.6))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            // Toggle Sign In/Sign Up prompt
            HStack {
                Text(showSignUp ? "Already a member?" : "Don't have an account?")
                    .fontWeight(.regular)
                    .foregroundColor(.gray)

                Button(action: {
                    withAnimation {
                        showSignUp.toggle()
                    }
                }) {
                    Text(showSignUp ? "Sign In" : "Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightBlue"))
                }
            }
            .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 0),
            alignment: .bottom
        )
        .background(
            // Bottom Decorative Circles
            HStack {
                Circle()
                    .fill(Color("gray"))
                    .frame(width: 70, height: 70)
                    .offset(x: -30, y: getRect().height < 750 ? 10 : 0)

                Spacer(minLength: 0)

                Circle()
                    .fill(Color("orange"))
                    .frame(width: 110, height: 110)
                    .offset(x: 40, y: 20)
            }
            .offset(y: getSafeArea().bottom + 30),
            alignment: .bottom
        )
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

// MARK: - Extensions

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }

    func getSafeArea() -> UIEdgeInsets {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first?.safeAreaInsets ?? UIEdgeInsets()
    }
}

