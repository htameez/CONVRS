//
//  Login.swift
//  ShopApp
//
//  Created by Istiaque Ahamed on 2/7/22.


import SwiftUI
import Firebase
import FirebaseAuth

struct Login: View {
    
    @State var email = ""
    @State var password = ""
    @State var errorMassage = ""
    var success = false

    var body: some View {
    
       VStack{
        
       Text("Sign In")
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
            
            
            // Forget Password...
            Button {
                
            } label:{
                
                Text("Forget Password?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            
            .frame(maxWidth: .infinity,alignment: .trailing)
            .padding(.top, 10)
            
            
            // Next Button....
            
            Button (action: {
                login()
                
            
                    
                
                    
                    
                
                
            },
                    label: {
                
                Image(systemName: "arrow.right")
                    
                    .font(.system(size: 24,weight: .bold))
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color("dark"))
                    .clipShape(Circle())
                
                // Shadow...
                    .shadow(color: Color("lightBlue").opacity(0.6), radius: 5, x: 0, y: 0)

            })
            
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top, 10)
           
           
            Text ("error massage")
               .font(.body)
               .foregroundColor(.red)
               .frame(maxWidth: .infinity,alignment: .leading)
               .padding(.top, 10)
               .opacity(0) //make it (1) for frontend visability
        
        
        }

        .padding()
        
    }
    
    
    func login() {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
            
            if error != nil {
                
                
               
                
               print(error!.localizedDescription)
   
            } else {
                
                print ("User has successfully logged in")
    
            }
            
        })
    }
   
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
     
}


