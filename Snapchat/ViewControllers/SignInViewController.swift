//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Joey Newfield on 1/13/18.
//  Copyright © 2018 Joey Newfield. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    
    @IBAction func turnUpTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("Hey we have an error:\(error)")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We had to create a user")
                    
                    if error != nil {
                        print("Hey we have an error:\(error)")
                    } else {
                        print("Created User Successfully!")
                        
            let user = Database.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
                
            } else{
                print("Signed in Successfully")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        }
        
    }
    

}

