//
//  register.swift
//  ShopApp
//
//  Created by Istiaque Ahamed on 3/7/22.
//

import Foundation
import Firebase
import FirebaseAuth

func register() {
    
    Auth.auth().createUser(withEmail: "", password: "", completion: {result, error in
        if error != nil {
            print(error!.localizedDescription)
        }else {
            
            return
        }
        
    })
}
