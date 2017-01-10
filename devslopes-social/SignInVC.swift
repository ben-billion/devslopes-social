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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

