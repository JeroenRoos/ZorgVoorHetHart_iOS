//
//  MyLoginViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import CryptoSwift

class MyLoginViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var checkboxStayLoggedin: CheckboxHelper!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var errorEmail: UILabel!
    
    let service: UserService = UserService()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Inloggen"
        self.hideKeyboardWhenTappedAround()
        
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        checkboxStayLoggedin.setTitle("Ingelogd blijven", for: .normal)
        checkboxStayLoggedin.setTitleColor(UIColor.black, for: .normal)
        checkboxStayLoggedin.isChecked = defaults.bool(forKey: "automaticLogin")
        
        btnForgotPassword.setTitle("Wachtwoord vergeten?", for: .normal)
        btnForgotPassword.setTitleColor(UIColor.black, for: .normal)

        errorEmail.textColor = UIColor.red
        errorEmail.font = errorEmail.font.withSize(10)
        errorEmail.isHidden = true
        
        inputEmail.placeholder = "Voer uw e-mailadres in"
        inputEmail.placeholderTextColor = UIColor.gray
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        self.inputEmail.delegate = self
        inputEmail.text = ""
        inputEmail.addTarget(self, action: #selector(emailDidEndEditing(_:)), for: .editingDidEnd)
        inputEmail.layer.borderColor = UIColor.red.cgColor
      
        errorPassword.textColor = UIColor.red
        errorPassword.font = errorPassword.font.withSize(10)
        errorPassword.isHidden = true
        
        inputPassword.placeholder = "Voer uw wachtwoord in"
        inputPassword.placeholderTextColor = UIColor.gray
        inputPassword.isSecureTextEntry = true
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.addTarget(self, action: #selector(passwordDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPassword.delegate = self
        inputPassword.layer.borderColor = UIColor.red.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        inputEmail.text = ""
        inputPassword.text = ""
    }
    
    @IBAction func btnLogin_OnClick(_ sender: Any)
    {
        var trimmedEmail : String? = nil
        var password : String? = nil
        
        if (!(inputEmail.text?.isEmpty)! &&
            !(inputPassword.text?.isEmpty)!)
           // && inputEmail.isValidEmail())
        {
            let email = inputEmail.text!
            trimmedEmail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
            password = inputPassword.text
            let hashedPassword = password?.sha512()
            self.btnLogin.isEnabled = false
            
            
            service.login(
                withSuccess: { (user: User) in
                    
                    let value = self.checkboxStayLoggedin.isChecked
                    self.defaults.set(value, forKey: "automaticLogin")
                    
                    if (value)
                    {
                        self.storeCredentialsInKeyChain(withPassword: hashedPassword!, andEmail: trimmedEmail!)
                    }
                    
                    User.loggedinUser = user
                    self.btnLogin.isEnabled = true
                    self.performSegue(withIdentifier: "loginFinish", sender: self)
                    self.navigationController?.popToRootViewController(animated: false)
            }, orFailure: { (error: String, title: String) in
                
                self.showAlertBox(withMessage: error, andTitle: title)
                self.btnLogin.isEnabled = true
            }, andEmail: trimmedEmail!, andPassword: hashedPassword!)
        }
    }
    
    private func storeCredentialsInKeyChain(withPassword password: String,
                                            andEmail email: String)
    {
        let passwordService = KeychainService().passwordService
        let emailService = KeychainService().emailService
        let account = KeychainService().keychainAccount
        
        KeychainService.save(service: passwordService, account: account, data: password)
        KeychainService.save(service: emailService, account: account, data: email)
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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
