//
//  LoginViewController.swift
//  Pediment-V1
//
//  Created by wafeeq on 5/10/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import KeychainSwift

class LoginViewController: UIViewController
{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataService().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "segueSignIn", sender: nil)
        }
    }
    
    func CompleteSignIn  (id: String) {
        let keyChain = DataService().keyChain
        keyChain.set(id, forKey: "uid")
    }
    
    @IBAction func SignIn(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.CompleteSignIn(id: user!.uid)
                    self.performSegue(withIdentifier: "segueSignIn", sender: nil)
                }
                else {
                    Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                        if error != nil {
                            print("Can't sign in user.")
                        }
                        else {
                            self.CompleteSignIn(id: user!.uid)
                            self.performSegue(withIdentifier: "SignIn", sender: nil)
                        }
                    }
                }
            }
        }
    }
}
