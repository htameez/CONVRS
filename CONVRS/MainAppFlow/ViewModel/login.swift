//
//  login.swift
//  ShopApp
//
//  Created by Istiaque Ahamed on 3/7/22.
//

import Foundation
import Firebase
import FirebaseAuth

func login() {
    
    Auth.auth().signIn(withEmail: "", password: "", completion: {result, error in
        if error != nil {
            print(error!.localizedDescription)
        }
        
    })
}
