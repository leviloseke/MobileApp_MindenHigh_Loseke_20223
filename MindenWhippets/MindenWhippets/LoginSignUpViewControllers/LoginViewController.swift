//
//  LoginViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 1/18/23.
//

import FirebaseAuth
import UIKit
import Firebase
import FirebaseCore
 

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
        
        // Do any additional setup after loading the view.
        
        func setUpElements()
        {
            errorLabel.alpha = 0
            
            Utilities.styleTextField(emailTextField)
            Utilities.styleTextField(passwordTextField)
            Utilities.styleFilledButton(loginButton)
        }
        
        
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
                let HomeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.HomeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = HomeViewController
                self.view.window?.makeKeyAndVisible()
                
                
            }
        }
    }
}
