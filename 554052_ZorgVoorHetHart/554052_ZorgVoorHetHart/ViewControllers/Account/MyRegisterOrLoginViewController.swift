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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Inloggen / Registreren"
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}