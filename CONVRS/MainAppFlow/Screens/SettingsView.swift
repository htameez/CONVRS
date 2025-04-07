//
//  SettingsView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

// MARK: - Main Settings View
struct SettingsView: View {
    @State private var selectedTheme = "Light"
    @State private var selectedLanguage = "English"
    @AppStorage("appTheme") private var appTheme = "Light"
    @AppStorage("appLanguage") private var appLanguage = "English"

    @EnvironmentObject var authService: AuthService
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var showPasswordPrompt = false
    @State private var passwordForUpdate = ""
    @State private var error = ""
    @State private var newEmail = ""
    @State private var showEmailChangePrompt = false

    let themes = ["Light", "Dark"]
    let languages = ["English", "Spanish", "French"]

    var body: some View {
        NavigationView {
            Form {
                // Account Management
                Section(header: Text("Account")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Phone", text: $phone)
                    Button("Save Changes") {
                        showPasswordPrompt = true
                    }
                }

                // Preferences
                Section(header: Text("Preferences")) {
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(themes, id: \.self) { theme in
                            Text(theme)
                        }
                    }
                    .onChange(of: selectedTheme) { newTheme in
                        appTheme = newTheme
                    }

                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                    .onChange(of: selectedLanguage) { newLanguage in
                        appLanguage = newLanguage
                    }
                }

                // Support Section
                Section(header: Text("Support")) {
                    NavigationLink(destination: HelpCenterView()) {
                        Text("Help Center")
                    }
                    NavigationLink(destination: LegalPrivacyView()) {
                        Text("Legal & Privacy")
                    }
                }

                if !error.isEmpty {
                    Section {
                        Text(error).foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear(perform: fetchUserInfo)
            .alert("Confirm Password", isPresented: $showPasswordPrompt) {
                SecureField("Enter password", text: $passwordForUpdate)
                Button("Update", action: updateUserInfo)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("To save your changes, please re-enter your password.")
            }
            .alert("Enter New Email", isPresented: $showEmailChangePrompt) {
                TextField("New Email", text: $newEmail)
                SecureField("Password", text: $passwordForUpdate)
                Button("Submit") {
                    updateEmail()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter your new email and password to confirm.")
            }
        }
    }

    func fetchUserInfo() {
        guard let uid = authService.currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { document, error in
            if let doc = document, doc.exists {
                let firstName = doc["firstName"] as? String ?? ""
                let lastName = doc["lastName"] as? String ?? ""
                name = "\(firstName) \(lastName)"
                email = doc["email"] as? String ?? ""
                phone = doc["phoneNumber"] as? String ?? ""
            }
        }
    }

    func updateUserInfo() {
        guard let user = Auth.auth().currentUser, let userEmail = user.email else { return }

        let credential = EmailAuthProvider.credential(withEmail: userEmail, password: passwordForUpdate)

        user.reauthenticate(with: credential) { result, error in
            if let error = error {
                self.error = "Authentication failed: \(error.localizedDescription)"
                return
            }

            let db = Firestore.firestore()
            let nameParts = name.split(separator: " ")
            let firstName = nameParts.first ?? ""
            let lastName = nameParts.dropFirst().joined(separator: " ")

            db.collection("users").document(user.uid).updateData([
                "firstName": firstName,
                "lastName": lastName,
                "phoneNumber": phone
            ]) { err in
                if let err = err {
                    self.error = "Failed to update: \(err.localizedDescription)"
                } else {
                    self.error = "Profile updated successfully!"
                }
            }
        }
    }

    func updateEmail() {
        guard let user = Auth.auth().currentUser else { return }

        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: passwordForUpdate)

        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                self.error = "Reauthentication failed: \(error.localizedDescription)"
                return
            }

            user.updateEmail(to: newEmail) { error in
                if let error = error {
                    self.error = "Email update failed: \(error.localizedDescription)"
                } else {
                    user.sendEmailVerification(completion: nil)
                    email = newEmail
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).updateData([
                        "email": newEmail
                    ])
                    self.error = "Email updated! Please verify your new address."
                }
            }
        }
    }
}

// MARK: - Help Center View
struct HelpCenterView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("How to use the app?").font(.headline)
                Text("-Ask an ethical question of your choice and an ethican response will be given")
                Text("- Access settings to customize your experience.")
                Text("- Contact support for any issues.")
            }
            .padding()
        }
        .navigationTitle("Help Center")
    }
}

// MARK: - Legal & Privacy View
struct LegalPrivacyView: View {
    var body: some View {
        ScrollView {
            Text("Terms and Coditions")
            Text(" ")
            Text("Data Collection and Usage:The platform may collect user data to train the AI model or improve its services.Personal data might be used to tailor recommendations or customize the user experience.")
            Text ("Privacy Policy: Clear guidelines on how personal information is handled, including storage, encryption, and sharing practices.Some platforms might include opt-in/opt-out features for data sharing with third parties.")
            Text ("User Rights and Ownership: Users may retain ownership of their data but grant the platform a license to use it for the purpose of AI training or service enhancement.The terms may define whether the AI-generated content belongs to the user or the platform.")
            Text ("Fair Use and Ethical Guidelines: Restrictions against using AI services for harmful, illegal, or unethical purposes. AI should be used responsibly, and users should not manipulate the system for malicious purposes.")
            Text ("Transparency and Explainability:The platform may outline how AI decisions are made, especially in sensitive areas such as credit scoring or hiring decisions. Users may have the right to request an explanation of how an AI system came to a particular conclusion or decision.")
            Text("AI Limitations and Accuracy:Disclaimer that the AI may not be perfect, and the results provided by AI are based on algorithms that are continually improving. Platforms may outline the risks associated with incorrect AI-generated outputs or recommendations.")
        }
        .navigationTitle("Legal & Privacy")
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
