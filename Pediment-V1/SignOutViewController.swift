//
//  SignOutViewController.swift
//  Pediment-V1
//
//  Created by wafeeq on 5/14/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class SignOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignOut (_ sender:Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        DataService().keyChain.delete("uid")
        dismiss(animated: true, completion: nil)
    }
    
}
