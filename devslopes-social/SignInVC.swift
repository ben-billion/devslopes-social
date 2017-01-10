//
//  ViewController.swift
//  devslopes-social
//
//  Created by Benjamin Neal on 1/9/17.
//  Copyright © 2017 Benjamin Neal. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func facebookBtnClicked(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BEN: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("BEN: User cancelld Facebook authentication")
            } else {
                print("BEN: Authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
            }
            
            
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("BEN: Unable to authenticate with Firebase")
            } else {
                print("BEN: Authenticated with Firebase")
            }
        })
    }

   @IBAction func signInPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("BEN: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("BEN: Unable to authenticate with Firebase using email - \(error)")
                        } else {
                            print("BEN: Successfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
}

