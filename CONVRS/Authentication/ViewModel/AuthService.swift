//
//  AuthService.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/31/25.
//

import Foundation
import FirebaseAuth

class AuthService: ObservableObject {
    @Published var user: User?
    @Published var isLoading = true

    init(preview: Bool = false) {
        if preview {
            self.isLoading = false
            self.user = nil // or mock a user to simulate logged in
        } else {
            listenToAuthChanges()
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self.user = user
                completion(.success(user))
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self.user = user
                completion(.success(user))
            }
        }
    }

    func signOut(completion: (() -> Void)? = nil) {
        do {
            try Auth.auth().signOut()
            user = nil
            completion?()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    private func listenToAuthChanges() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
            self.isLoading = false
        }
    }
}
