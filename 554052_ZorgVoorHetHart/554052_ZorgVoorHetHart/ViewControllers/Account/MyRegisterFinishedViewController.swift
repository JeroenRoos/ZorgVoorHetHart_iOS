//
//  MyRegisterFinishedViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 19/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyRegisterFinishedViewController: UIViewController
{
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtActivate: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtDescriptionEmail: UILabel!
    @IBOutlet weak var txtTitleEmail: UILabel!
    @IBOutlet weak var imgCheckMark: UIImageView!
    
    var user: User? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registratie afgerond"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Perform the segue to the Login ViewController when the User presses this button
    @IBAction func btnLogin_OnClick(_ sender: Any)
    {
        self.performSegue(withIdentifier: "waitingActivation", sender: self)
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        txtTitleEmail.text = "Bedankt voor het registreren"
        txtTitleEmail.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        txtDescriptionEmail.text = "U heeft een e-mail ontvangen op:"
        
        if (user?.emailAddress != "")
        {
            txtEmail.text = user!.emailAddress
        }
        else
        {
            txtEmail.text = "placeholder@email.com"
        }
        txtEmail.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        txtActivate.text = "Hiermee kunt u uw account activeren"
    }
}
