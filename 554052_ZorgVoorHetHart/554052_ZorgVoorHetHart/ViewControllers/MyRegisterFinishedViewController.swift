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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registratie afgerond"
        
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        txtTitleEmail.text = "Bedankt voor het registreren"
        txtTitleEmail.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        
        txtDescriptionEmail.text = "U heeft een email ontvangen op:"
        txtEmail.font = txtEmail.font.withSize(14)
        
        txtEmail.text = "placeholder@email.com"
        txtEmail.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
        
        txtActivate.text = "Hiermee kunt u uw account activeren"
        txtEmail.font = txtEmail.font.withSize(14)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
