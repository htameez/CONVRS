//
//  SignUp.swift
//  ShopApp
//
//  Created by Istiaque Ahamed on 2/7/22.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct SignUpView: View {
    @EnvironmentObject var authService: AuthService
    @Environment(\.dismiss) var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case firstName, lastName, phoneNumber, email, password, confirmPassword
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.theme.blue, Color.theme.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(FontManager.lato(.regular, size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                nameFields
                credentialFields
                signUpButton
                errorMessageView
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    
    private var nameFields: some View {
        Group {
            TextField("First Name", text: $firstName)
                .focused($focusedField, equals: .firstName)
                .submitLabel(.next)
                .onSubmit { focusedField = .lastName }
            
            TextField("Last Name", text: $lastName)
                .focused($focusedField, equals: .lastName)
                .submitLabel(.next)
                .onSubmit { focusedField = .phoneNumber }
        }
        .font(FontManager.lato(.regular, size: 14))
        .padding()
        .foregroundColor(.white)
        .background(Color.white.opacity(0.5))
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
        .padding(.horizontal)
        .autocapitalization(.words)
    }

    private var credentialFields: some View {
        Group {
            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .focused($focusedField, equals: .phoneNumber)
                .submitLabel(.next)
                .onSubmit { focusedField = .email }
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { focusedField = .password }

            SecureField("Password", text: $password)
                .focused($focusedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { focusedField = .confirmPassword }

            SecureField("Confirm Password", text: $confirmPassword)
                .focused($focusedField, equals: .confirmPassword)
                .submitLabel(.go)
                .onSubmit { signUp() }
        }
        .font(FontManager.lato(.regular, size: 14))
        .padding()
        .foregroundColor(.white)
        .background(Color.white.opacity(0.5))
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
        .autocapitalization(.none)
        .padding(.horizontal)
    }

    private var signUpButton: some View {
        Button(action: signUp) {
            Text("Create Account")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(Color.theme.purple)
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }

    private var errorMessageView: some View {
        Group {
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
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
                saveUserInfoToFirestore {
                    dismiss() // now only dismiss after Firestore write completes
                }
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }

    private func saveUserInfoToFirestore(completion: @escaping () -> Void) {
        guard let uid = authService.currentUser?.uid else { return }

        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber
        ]

        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                errorMessage = "Failed to save user data: \(error.localizedDescription)"
            } else {
                completion()
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AuthService(preview: true))
    }
}

