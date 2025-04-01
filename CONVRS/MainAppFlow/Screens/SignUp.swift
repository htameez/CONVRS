//
//  SignUp.swift
//  ShopApp
//
//  Created by Istiaque Ahamed on 2/7/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUp: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    var body: some View {
    
    VStack{
        
        Text("Sign Up")
            .font(.title)
            .fontWeight(.bold)
        
            // for letter spacing
        
            .kerning(1.9)
            .frame(maxWidth: .infinity,alignment: .leading)
        
        
            // email and password
        
        VStack(alignment: .leading, spacing: 8, content: {
            
            Text("User Name")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
          
            TextField("something@domain.com", text: $email)
            // Increasing font size and changing color
                
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color("gray"))
                .padding(.top, 5)
            
            
            Divider()
            
        })
        .padding(.top,25)
        
        
        VStack(alignment: .leading, spacing: 8, content: {
            
            Text("Password")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
          
            SecureField("1234567", text: $password)
            // Increasing font size and changing color
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color("gray"))
                .padding(.top, 5)
            
            
            Divider()
            
        })
        .padding(.top,20)
        
        
        
        
        
        // Next Button....
        
        Button {
            register()
        } label: {
            
            Image(systemName: "arrow.right")
                .font(.system(size: 24,weight: .bold))
                .foregroundColor(.gray)
                .padding()
                .background(Color("dark"))
                .clipShape(Circle())
            
            // Shadow...
                .shadow(color: Color("lightBlue").opacity(0.6), radius: 5, x: 0, y: 0)
            
            
        }
        
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.top, 10)
        
        
        
    }
    
    .padding()
    
    }
    
    
    
    func register() {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                
                print("User cretated successfully")
            }
            
        })
    }

    
    
    
    
    
}
    


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
    
    

}
