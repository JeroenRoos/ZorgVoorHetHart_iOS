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
        
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        txtDescription.font = txtDescription.font.withSize(12)
        
        activateAccount()
    }
    
    private func activateAccount()
    {
        service.activateAccount(withSuccess: { (message) in
            self.txtTitle.text = "Uw account is geactiveerd!"
            self.txtDescription.text = "U kunt nu inloggen met uw account."
        }, orFailure: { (error) in
            self.txtTitle.text = "Er is iets fout gegaan tijdens het activeren van uw account"
            self.txtDescription.text = "Probeer het opnieuw door de link in de mail opnieuw te openen."
        }, andToken: activationToken!)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogin_OnClick(_ sender: Any)
    {
        self.performSegue(withIdentifier: "continueLogin", sender: self)
    }
}
