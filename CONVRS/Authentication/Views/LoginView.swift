//
//  Login.swift
//  ShopApp
//
//  Created by Istiaque Ahamed on 2/7/22.

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var successMessage = ""
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case email
        case password
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.theme.blue,
                    Color.theme.purple
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Sign In")
                    .font(FontManager.lato(.regular, size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                TextField("Email", text: $email)
                    .font(FontManager.lato(.regular, size: 14))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(focusedField == .email ? Color.theme.blue : Color.white, lineWidth: 1))
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .font(FontManager.lato(.regular, size: 14))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(focusedField == .password ? Color.theme.blue : Color.white, lineWidth: 1))
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        login()
                    }
                    .autocapitalization(.none)
                    .padding(.horizontal)

                Button("Forgot Password?") {
                    guard !email.isEmpty else {
                        errorMessage = "Please enter your email address."
                        return
                    }

                    authService.resetPassword(email: email) { result in
                        switch result {
                        case .success:
                            successMessage = "Password reset email sent."
                            errorMessage = ""
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                            successMessage = ""
                        }
                    }
                }
                .font(FontManager.lato(.regular, size: 15))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)

                Button(action: login) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.theme.purple)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                if !successMessage.isEmpty {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .font(.footnote)
                }
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .center)
            
            Spacer()
        }
    }

    private func login() {
        authService.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                dismiss()
            case .failure(let error):
                errorMessage = error.localizedDescription
                successMessage = ""
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthService(preview: true))
    }
}
