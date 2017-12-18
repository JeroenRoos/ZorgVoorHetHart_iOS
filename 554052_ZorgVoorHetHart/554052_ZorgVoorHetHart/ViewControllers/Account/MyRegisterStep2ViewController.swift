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
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var errorPasswordCheck: UILabel!
    
    private let service: UserService = UserService()
    var user: User? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 2 van 2"
        self.hideKeyboardWhenTappedAround()
        
        errorEmail.textColor = UIColor.red
        errorEmail.font = errorEmail.font.withSize(10)
        errorEmail.isHidden = true
        
        btnFinish.setTitle("Registratie afronden", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        inputEmail.placeholder = "Vul uw email in"
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        inputEmail.addTarget(self, action: #selector(emailDidEndEditing(_:)), for: .editingDidEnd)
        self.inputEmail.delegate = self
        
        errorPassword.textColor = UIColor.red
        errorPassword.font = errorPassword.font.withSize(10)
        errorPassword.isHidden = true
        
        inputPassword.placeholder = "Vul uw wachtwoord in"
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.isSecureTextEntry = true
        inputPassword.addTarget(self, action: #selector(passwordDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPassword.delegate = self
        
        errorPasswordCheck.textColor = UIColor.red
        errorPasswordCheck.font = errorPasswordCheck.font.withSize(10)
        errorPasswordCheck.isHidden = true
        
        inputPasswordCheck.placeholder = "Vul uw wachtwoord in"
        inputPasswordCheck.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPasswordCheck.layer.borderWidth = 0
        inputPasswordCheck.isSecureTextEntry = true
        inputPasswordCheck.addTarget(self, action: #selector(passwordCheckDidEndEditing(_:)), for: .editingDidEnd)
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
    
    @objc func emailDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorEmail, errorText: "Email kan niet leeg zijn")
        
        // Check and set error message if the email address is not valid
        textField.setErrorMessageInvalidEmail(errorLabel: errorEmail, errorText: "Dit is geen correct emailadres")
    }
    
    @objc func passwordDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorPassword, errorText: "Wachtwoord kan niet leeg zijn")
    }
    
    @objc func passwordCheckDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorPasswordCheck, errorText: "Wachtwoord kan niet leeg zijn")
        
        // Check and set error message if the password is identical with the first password
        textField.setErrorMessagePasswordIdentical(errorLabel: errorPasswordCheck, errorText: "De wachtwoorden komen niet overeen", otherPassword: inputPassword)
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
