//
//  MyForgotPasswordEmailViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 28/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyPasswordResetEmailViewController: UIViewController
{
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtActivate: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    
    var emailAddress: String? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Email verzonden"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        txtTitle.text = "Email verzonden!"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        txtDescription.text = "U heeft een email ontvangen op:"
        txtDescription.font = txtDescription.font.withSize(12)
        
        if (emailAddress != "")
        {
            txtEmail.text = emailAddress
        }
        else
        {
            txtEmail.text = "placeholder@email.com"
        }
        txtEmail.font = UIFont(name:"HelveticaNeue-Bold", size: 13.0)
        
        txtActivate.text = "Hiermee kunt u uw wachtwoord opnieuw instellen"
        txtActivate.font = txtActivate.font.withSize(12)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
