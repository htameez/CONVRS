//
//  AboutUsView.swift
//  CONVRS
//
//  Created by Hamna Tameez on 3/3/25.
//

import SwiftUI

// Profile Model
struct Profile: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var bio: String
    var imageName: String
}

// Sample Data
let profiles = [
    Profile(name: "Marissa Menjarez", location: "Dallas, TX", bio: "Computer Engineering, Computer Science & Data Analytics\nTraveled to Europe, Mexico, and 10/50 states\nInterned as an educational engagement engineer", imageName: "marissa"),
    Profile(name: "Emilio Munoz", location: "San Antonio, TX", bio: "Computer Science & Data Science\nBaptized in the Vatican\nBuilt a SuperSonic Rocket", imageName: "emilio"),
    Profile(name: "Hamna Tameez", location: "Memphis, TN", bio: "Computer Science\nWent to an international school for a year\nFocus on Software Engineering", imageName: "hamna")
]

// ProfileCard View
struct ProfileCardView: View {
    var profile: Profile
    
    var body: some View {
        VStack {
            Image(profile.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .padding(.top, 10)
            
            Text(profile.name)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 5)
            
            Text(profile.location)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(profile.bio)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
    }
}

// About Us View with swipeable profiles
struct AboutUsView: View {
    var body: some View {
        TabView {
            ForEach(profiles) { profile in
                ProfileCardView(profile: profile)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Enable swipeable pages
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}



