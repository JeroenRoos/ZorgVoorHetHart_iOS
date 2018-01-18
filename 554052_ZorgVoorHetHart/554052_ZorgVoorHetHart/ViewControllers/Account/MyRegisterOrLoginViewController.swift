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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Inloggen / Registreren"
        
        if (defaults.bool(forKey: "automaticLogin"))
        {
            // Retrieve Email and Password if they exist in the keychain
            btnLogin.isHidden = true
            btnRegister.isHidden = true
            txtOf.isHidden = true
            
            let passwordService = KeychainService().passwordService
            let emailService = KeychainService().emailService
            let account = KeychainService().keychainAccount
            if let str = KeychainService.load(service: passwordService, account: account)
            {
                retrievedPassword = str
            }
            if let str = KeychainService.load(service: emailService, account: account)
            {
                retrievedEmail = str
            }
            tryAutomaticLogin()
        }
        
        initUserInterface()
    }
    
    private func tryAutomaticLogin()
    {
        if (retrievedEmail != ""
            && retrievedPassword != "")
        {
            SwiftSpinner.show("Bezig met inloggen...")
            
            service.login(withSuccess: { (user: User) in
                self.btnLogin.isHidden = false
                self.btnRegister.isHidden = false
                self.txtOf.isHidden = false
                User.loggedinUser = user
                SwiftSpinner.hide()
                self.performSegue(withIdentifier: "automaticLogin", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnLogin.isHidden = false
                self.btnRegister.isHidden = false
                self.txtOf.isHidden = false
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andEmail: retrievedEmail, andPassword: retrievedPassword)
        }
        else
        {
            self.btnLogin.isHidden = false
            self.btnRegister.isHidden = false
            self.txtOf.isHidden = false
        }
    }
    
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
