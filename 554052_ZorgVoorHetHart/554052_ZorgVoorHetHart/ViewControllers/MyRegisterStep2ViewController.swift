//
//  MyRegisterStep2ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyRegisterStep2ViewController: UIViewController
{
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var inputPasswordCheck: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 2 van 2"
        
        btnFinish.setTitle("Registratie afronden", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        inputEmail.placeholder = "Vul uw email in"
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        
        inputPassword.placeholder = "Vul uw wachtwoord in"
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.isSecureTextEntry = true
        
        inputPasswordCheck.placeholder = "Vul uw wachtwoord in"
        inputPasswordCheck.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPasswordCheck.layer.borderWidth = 0
        inputPasswordCheck.isSecureTextEntry = true
    }

    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
                
        self.performSegue(withIdentifier: "registerFinish", sender: self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
