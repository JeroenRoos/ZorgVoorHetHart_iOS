//
//  MyPasswordResetSuccessViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 28/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyPasswordResetSuccessViewController: UIViewController
{
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Succes"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        initUserInterface()
    }
    
    private func initUserInterface()
    {
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        txtDescription.font = txtDescription.font.withSize(12)
        txtTitle.text = "Uw wachtwoord is aangepast!"
        txtDescription.text = "U kunt nu opnieuw inloggen met uw account."
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
