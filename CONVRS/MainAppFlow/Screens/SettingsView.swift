//
//  SettingsView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

// MARK: - Main Settings View
struct SettingsView: View {
    @State private var selectedTheme = "Light"
    @State private var selectedLanguage = "English"
    @AppStorage("appTheme") private var appTheme = "Light"
    @AppStorage("appLanguage") private var appLanguage = "English"
    
    let themes = ["Light", "Dark"]
    let languages = ["English", "Spanish", "French"]
    
    var body: some View {
        NavigationView {
            Form {
                // Account Management
                Section(header: Text("Account")) {
                    NavigationLink(destination: AccountManagementView()) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Text("Manage Account")
                                .font(.headline)
                        }
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
            }
            .navigationTitle("Settings")
            .background(themeColor())
        }
    }
    
    // Function to Change Background Color Based on Theme
    func themeColor() -> Color {
        switch appTheme {
        case "Dark": return Color.black
        case "Blue": return Color.blue.opacity(0.2)
        case "Green": return Color.green.opacity(0.2)
        default: return Color.white
        }
    }
}

// MARK: - Account Management View
struct AccountManagementView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Personal Info")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                TextField("Phone", text: $phone)
            }
            Button("Save") {
                // Save changes logic
            }
        }
        .navigationTitle("Manage Account")
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
