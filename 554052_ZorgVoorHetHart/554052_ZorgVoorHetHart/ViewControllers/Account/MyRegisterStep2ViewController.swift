//
//  MyRegisterStep2ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import CryptoSwift

class MyRegisterStep2ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var inputPasswordCheck: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var errorPasswordCheck: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtPasswordCheck: UILabel!
    @IBOutlet weak var txtPassword: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    
    var user: User? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 2 van 3"
        self.hideKeyboardWhenTappedAround()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }
    
    // Called when the user pressed the "Volgende" button, this method wil check all the user input and determine the validity
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        // Check the password and email for validity
        if (!(inputEmail.text?.isEmpty)! &&
            !(inputPassword.text?.isEmpty)! &&
            !(inputPasswordCheck.text?.isEmpty)! &&
            inputEmail.isValidEmail() &&
            inputPassword.text == inputPasswordCheck.text)
        {
            // Get and trim the email, iOS automatically puts a space to the end if you use autocorrect to finish your words
            let email = inputEmail.text!
            let trimmedEmail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            // Hash the password with Sha512 (CryptoSwift CocaoPod). This way the password will not be in plaintext when send to the API
            let password = inputPassword.text!
            let hashedPassword = password.sha512()
            
            // Put the values in user
            user?.emailAddress = trimmedEmail
            user?.password = hashedPassword
            
            // Perform a segue to the next ViewController
            self.performSegue(withIdentifier: "registerNext2", sender: self)
        }
        else
        {
            // If the input isn't valid, go through all the checks for each input field, this wil display the error message if this wasn't already the case
            emailDidEndEditing(inputEmail)
            passwordDidEndEditing(inputPassword)
            passwordCheckDidEndEditing(inputPasswordCheck)
        }
    }
    
    // The function that will be called when the user stops editing the email input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func emailDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorEmail, andText: "Email kan niet leeg zijn")
        
        // Check and set error message if the email address is not valid
        textField.setErrorMessageInvalidEmail(withLabel: errorEmail, andText: "Dit is geen correct emailadres")
    }
    
    // The function that will be called when the user stops editing the password input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func passwordDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorPassword, andText: "Wachtwoord kan niet leeg zijn")
    }
    
    // The function that will be called when the user stops editing the password input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func passwordCheckDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorPasswordCheck, andText: "Wachtwoord kan niet leeg zijn")
        
        // Check and set error message if the password is identical with the first password
        textField.setErrorMessagePasswordIdentical(withLabel: errorPasswordCheck, andText: "De wachtwoorden komen niet overeen", andOtherPassword: inputPassword)
    }
    
    // Perpare the data for the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Identify the segue
        if(segue.identifier == "registerNext2")
        {
            // Pass the registering user to the next ViewController
            if let viewController = segue.destination as? MyRegisterStep3ViewController
            {
                viewController.user = user
            }
        }
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        txtTitle.text = "Inloggegevens"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        errorEmail.textColor = UIColor.red
        errorEmail.font = errorEmail.font.withSize(10)
        errorEmail.isHidden = true
        
        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        inputEmail.placeholder = "Vul uw e-mailadres in"
        inputEmail.placeholderTextColor = UIColor.gray
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        inputEmail.addTarget(self, action: #selector(emailDidEndEditing(_:)), for: .editingDidEnd)
        self.inputEmail.delegate = self
        inputEmail.layer.borderColor = UIColor.red.cgColor
        
        errorPassword.textColor = UIColor.red
        errorPassword.font = errorPassword.font.withSize(10)
        errorPassword.isHidden = true
        
        inputPassword.placeholder = "Vul uw wachtwoord in"
        inputPassword.placeholderTextColor = UIColor.gray
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.isSecureTextEntry = true
        inputPassword.addTarget(self, action: #selector(passwordDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPassword.delegate = self
        inputPassword.layer.borderColor = UIColor.red.cgColor
        
        errorPasswordCheck.textColor = UIColor.red
        errorPasswordCheck.font = errorPasswordCheck.font.withSize(10)
        errorPasswordCheck.isHidden = true
        
        inputPasswordCheck.placeholder = "Herhaal uw wachtwoord in"
        inputPasswordCheck.placeholderTextColor = UIColor.gray
        inputPasswordCheck.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPasswordCheck.layer.borderWidth = 0
        inputPasswordCheck.isSecureTextEntry = true
        inputPasswordCheck.addTarget(self, action: #selector(passwordCheckDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPasswordCheck.delegate = self
        inputPasswordCheck.layer.borderColor = UIColor.red.cgColor
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
