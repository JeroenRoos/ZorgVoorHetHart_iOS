//
//  MyRegisterOrLoginViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 13/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class MyRegisterOrLoginViewController: UIViewController
{

    @IBOutlet weak var txtOf: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    private var retrievedPassword: String = ""
    private var retrievedEmail: String = ""
    let service: UserService = UserService()
    let manager: UserManager = UserManager()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Inloggen / Registreren"
        
        // Check if the automatic login UserDefault is true
        if (defaults.bool(forKey: "automaticLogin"))
        {
            btnLogin.isHidden = true
            btnRegister.isHidden = true
            txtOf.isHidden = true
            
            // Retrieve Email and Password if they exist in the keychain
            let passwordService = KeychainService().passwordService
            let emailService = KeychainService().emailService
            let account = KeychainService().keychainAccount
            
            // Try to get the password from the Keychain
            if let str = KeychainService.load(service: passwordService, account: account)
            {
                retrievedPassword = str
            }
            
            // Try to get the e-mail from the Keychain
            if let str = KeychainService.load(service: emailService, account: account)
            {
                retrievedEmail = str
            }
            
            // Try automatic login with the retrieved e-mail and password
            tryAutomaticLogin()
        }
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }
    
    // Try automatic login with e-mail and password retrieved from the Keychain
    private func tryAutomaticLogin()
    {
        // Check if the retrieved Credentials aren't empty
        if (retrievedEmail != ""
            && retrievedPassword != "")
        {
            // Show the spinner indicating a network request is working
            SwiftSpinner.show("Bezig met inloggen...")
            
            // Try the login call resulting in a success or failure callback. Set the disabled UI to visible for later use of this ViewController
            service.login(withSuccess: { (user: User) in
                self.btnLogin.isHidden = false
                self.btnRegister.isHidden = false
                self.txtOf.isHidden = false
                User.loggedinUser = user
                
                // Hide the spinner and perform a segue to the Meting Home Viewcontroller
                SwiftSpinner.hide()
                self.performSegue(withIdentifier: "automaticLogin", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnLogin.isHidden = false
                self.btnRegister.isHidden = false
                self.txtOf.isHidden = false
                
                // Hide the spinner and show an alertbox with a message and title
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andEmail: retrievedEmail, andPassword: retrievedPassword)
        }
        else
        {
            // If the retrieved credentials aren't valid, enable the UI to let the user register an account or login
            self.btnLogin.isHidden = false
            self.btnRegister.isHidden = false
            self.txtOf.isHidden = false
        }
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        txtOf.text = "of"
        txtOf.textColor = UIColor.black
        txtOf.font = txtOf.font.withSize(18)
        
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnRegister.setTitle("Account aanmaken", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnRegister.backgroundColor = UIColor(rgb: 0x1BC1B7)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindForm(sender: UIStoryboardSegue)
    {
        // ... 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // ...
    }
}
