//
//  MyLoginViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

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
        
        btnForgotPassword.setTitle("Wachtwoord vergeten?", for: .normal)
        btnForgotPassword.setTitleColor(UIColor.black, for: .normal)

        errorEmail.textColor = UIColor.red
        errorEmail.font = errorEmail.font.withSize(10)
        errorEmail.isHidden = true
        
        inputEmail.placeholder = "Voer uw emailaders in"
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        self.inputEmail.delegate = self
        inputEmail.addTarget(self, action: #selector(emailDidEndEditing(_:)), for: .editingDidEnd)
      
        errorPassword.textColor = UIColor.red
        errorPassword.font = errorPassword.font.withSize(10)
        errorPassword.isHidden = true
        
        inputPassword.placeholder = "Voer uw wachtwoord in"
        inputPassword.isSecureTextEntry = true
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.addTarget(self, action: #selector(passwordDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPassword.delegate = self
    }
    
    @IBAction func btnLogin_OnClick(_ sender: Any)
    {
        var doRequest = true
        var trimmedEmail : String? = nil
        var password : String? = nil
        
        if (!(inputEmail.text?.isEmpty)! && !(inputPassword.text?.isEmpty)!)
        {
            //if (inputEmail.isValidEmail())
            //{
                let email = inputEmail.text!
                trimmedEmail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
                password = inputPassword.text
            //}
            //else
            //{
            //    doRequest = false
            //}
        }
        else
        {
            doRequest = false
        }
        
        if (doRequest)
        {
            service.login(
                withSuccess: { (user: User) in
                    User.loggedinUser = user
                    self.performSegue(withIdentifier: "loginFinish", sender: self)
            }, orFailure: { (error: String) in
                
            }, andEmail: trimmedEmail!, andPassword: password!)
        }
    }
    
    @objc func emailDidEndEditing(_ textField: UITextField)
    {
        errorEmail.isHidden = false
        if ((textField.text?.isEmpty)!)
        {
            errorEmail.text = "Emailadres kan niet leeg zijn"
        }
        else if (!textField.isValidEmail())
        {
            errorEmail.text = "Dit is geen correct emailadres"
        }
        else
        {
            errorEmail.isHidden = true
        }
    }
    
    @objc func passwordDidEndEditing(_ textField: UITextField)
    {
        errorPassword.isHidden = false
        if ((textField.text?.isEmpty)!)
        {
            errorPassword.text = "Wachtwoord kan niet leeg zijn"
        }
        else
        {
            errorPassword.isHidden = true
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
