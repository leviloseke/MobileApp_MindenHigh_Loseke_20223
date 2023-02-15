//
//  ViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 1/18/23.
//


import UIKit




class StartController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
            
            
            setUpElements()
        }
        
        func setUpElements() {
            
            Utilities.styleFilledButton(signUpButton)
            Utilities.styleHollowButton(loginButton)
            
            
            
        }
    }

