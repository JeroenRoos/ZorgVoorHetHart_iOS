//
//  MyRegisterOrLoginViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 13/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyRegisterOrLoginViewController: UIViewController
{

    @IBOutlet weak var txtOf: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    private var retrievedPassword: String = ""
    private var retrievedEmail: String = ""
    let service: UserService = UserService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Inloggen / Registreren"
        
        // Retrieve Email and Password if they exist in the keychain
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
    
    private func tryAutomaticLogin()
    {
        if (retrievedEmail != "" && retrievedPassword != "")
        {
            service.login(withSuccess: { (user: User) in
                User.loggedinUser = user
                self.performSegue(withIdentifier: "automaticLogin", sender: self)
            }, orFailure: { (error: String) in
                
            }, andEmail: retrievedEmail, andPassword: retrievedPassword)
        }
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
