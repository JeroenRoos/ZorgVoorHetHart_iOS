//
//  MyAccountActivatedViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 20/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyAccountActivatedViewController: UIViewController
{
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    private let service: UserService = UserService()
    var activationToken: String? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Account geactiveerd"
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }

    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        txtDescription.font = txtDescription.font.withSize(12)
        txtTitle.text = "Uw account is geactiveerd!"
        txtDescription.text = "U kunt nu inloggen met uw account."
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // Perform the segue to the Login ViewController when the User presses this button
    @IBAction func btnLogin_OnClick(_ sender: Any)
    {
        self.performSegue(withIdentifier: "continueLogin", sender: self)
    }
}
