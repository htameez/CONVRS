//
//  SettingsView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var selectedTheme = "Light"
    @State private var selectedLanguage = "English"
    
    let themes = ["Light", "Dark", "Blue", "Green"]
    let languages = ["English", "Spanish", "French", "German"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    NavigationLink(destination: Text("Manage Profile")) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Text("John Doe")
                                .font(.headline)
                        }
                    }
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(themes, id: \..self) { theme in
                            Text(theme)
                        }
                    }
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \..self) { language in
                            Text(language)
                        }
                    }
                }
                
                Section(header: Text("Support")) {
                    NavigationLink(destination: Text("FAQ & Help")) {
                        Text("Help Center")
                    }
                    NavigationLink(destination: Text("Terms & Conditions")) {
                        Text("Legal & Privacy")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
