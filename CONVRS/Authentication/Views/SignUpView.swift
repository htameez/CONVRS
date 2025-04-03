//
//  SignUp.swift
//  ShopApp
//
//  Created by Istiaque Ahamed on 2/7/22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authService: AuthService
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case email
        case password
        case confirmPassword
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
                Text("Sign Up")
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
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .confirmPassword
                    }
                    .autocapitalization(.none)
                    .padding(.horizontal)

                SecureField("Confirm Password", text: $confirmPassword)
                    .font(FontManager.lato(.regular, size: 14))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(focusedField == .confirmPassword ? Color.theme.blue : Color.white, lineWidth: 1))
                    .focused($focusedField, equals: .confirmPassword)
                    .submitLabel(.go)
                    .onSubmit {
                        signUp()
                    }
                    .autocapitalization(.none)
                    .padding(.horizontal)
                
                Button(action: signUp) {
                    Text("Create Account")
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
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }

    private func signUp() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }

        authService.signUp(email: email, password: password) { result in
            switch result {
            case .success:
                dismiss()
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthService(preview: true))
    }
}
