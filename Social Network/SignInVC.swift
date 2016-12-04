//
//  ViewController.swift
//  Social Network
//
//  Created by Sergiu Atodiresei on 30.11.2016.
//  Copyright © 2016 SergiuApps. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self){ (result, error) in
            if error != nil {
                print("Sergiu: Unable to authenticate with Facebook \(error)")
            } else if result?.isCancelled == true {
                print("Sergiu: User cancelled Facebook authentication")
            } else {
                print("Sergiu: Succesfully authenticated with Facebook")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Sergiu: Unable to authenticate with Firebase\(error)")
            }else {
                print("Sergiu: Succesfully authenticated with Firebase")
                if let user = user {
                    self.completeSingIn(id: user.uid)
                }
            }
        })
    }

    @IBAction func sigInTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error != nil {
                        //self.showErrorAlert("Wrong Password", message: "The password is invalid")
                    //print(error.unsafelyUnwrapped)
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Sergiu: Unable to authenticate with Firebase using email\(error)")
                        }else {
                            print("Sergiu: Succesfully authenticated with Firebase")
                            if let user = user {
                                self.completeSingIn(id: user.uid)
                            }
                        }

                    })
                }else {
                    print("Sergiu: Email user authenticated with Firebase")
                    if let user = user {
                        self.completeSingIn(id: user.uid)
                    }
                }
            })
        }
    }
    
    func showErrorAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func completeSingIn(id: String){
        let saveSuccessful: Bool = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        if saveSuccessful {
            print("Sergiu: Salvat in keychain")
            performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        }

    }

    
    
}

