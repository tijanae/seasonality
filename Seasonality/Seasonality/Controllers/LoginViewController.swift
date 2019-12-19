//
//  LoginViewController.swift
//  Seasonality
//
//  Created by Jack Wong on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let demoMode = true

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.addSubview(loginView)
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
           
           // Hide the error label
        loginView.errorLabel.alpha = 0
           
           // Style the elements
//        Utilities.styleTextField(loginView.emailTextField)
//        Utilities.styleSecureTextField(loginView.passwordTextField)
//        Utilities.styleFilledButton(loginView.loginButton)
        loginView.loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
           
       }
    
    @objc func buttonTapped(){
        // Signing in the user
        
        // Create cleaned versions of the text field
        let email = loginView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = loginView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.loginView.errorLabel.text = error!.localizedDescription
                self.loginView.errorLabel.alpha = 1
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
       
}

