//
//  MyRegisterStep2ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyRegisterStep2ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var inputPasswordCheck: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    
    
    private let service: UserService = UserService()
    var user: User? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 2 van 2"
        self.hideKeyboardWhenTappedAround()
        
        btnFinish.setTitle("Registratie afronden", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        inputEmail.placeholder = "Vul uw email in"
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        self.inputEmail.delegate = self
        
        inputPassword.placeholder = "Vul uw wachtwoord in"
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.isSecureTextEntry = true
        self.inputPassword.delegate = self
        
        inputPasswordCheck.placeholder = "Vul uw wachtwoord in"
        inputPasswordCheck.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPasswordCheck.layer.borderWidth = 0
        inputPasswordCheck.isSecureTextEntry = true
        self.inputPasswordCheck.delegate = self
    }

    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
        user?.emailAddress = inputEmail.text!
        user?.password = inputPassword.text!
        
        service.register(withSuccess: { (message: String) in
            
            self.performSegue(withIdentifier: "registerFinish", sender: self)
        }, orFailure: { (error: String) in
            
        }, andUser: user!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass user to next ViewController
        if(segue.identifier == "registerFinish")
        {
            if let viewController = segue.destination as? MyRegisterFinishedViewController
            {
                viewController.user = user
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
