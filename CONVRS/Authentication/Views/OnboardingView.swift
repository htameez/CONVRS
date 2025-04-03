//
//  Onboarding.swift
//  CONVRS
//
//  Created by Istiaque Ahamed on 2/7/22.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.theme.blue,
                        Color.theme.purple
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    Spacer()

                    VStack(spacing: 10) {
                        Text("Welcome to")
                            .font(FontManager.lato(.regular, size: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        HStack(spacing: 10) {
                            Text("CONVRS")
                                .font(FontManager.poppins(.bold, size: 45))
                                .foregroundColor(.white)

                            Image("convrs_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                        Text("An ethical discussion chatbot that helps you explore ideas with honesty and empathy.")
                            .font(FontManager.lato(.regular, size: 15))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer(minLength: 20)

                    VStack(spacing: 20) {
                        NavigationLink(destination: LoginView()) {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(Color.theme.purple)
                                .cornerRadius(12)
                        }

                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    Onboarding()
        .environmentObject(AuthService(preview: true))
}
