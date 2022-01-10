//
//  SignUpViewModel.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/8/22.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject{
    let auth = Auth.auth()
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, link: password) { result, error in
            guard result != nil, error == nil else{
                return
            }
            //Successful
            
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping(String)-> Void){
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else{
                print(error?.localizedDescription)
                completion(error!.localizedDescription)
                return
            }
        }
        
    }
}
