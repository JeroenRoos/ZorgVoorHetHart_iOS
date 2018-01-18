//
//  MyForgotPasswordViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 28/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import SwiftSpinner

class MyPasswordResetViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var btnSendEmail: UIButton!
    @IBOutlet weak var errorEmail: UILabel!
    
    private var emailAddress: String = ""
    let service: UserService = UserService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Wachtwoord vergeten"
        self.hideKeyboardWhenTappedAround()
        
        initUserInterface()
    }

    @IBAction func btnSendEmail_OnClick(_ sender: Any)
    {
        if (!(inputEmail.text?.isEmpty)! &&
            inputEmail.isValidEmail())
        {
            SwiftSpinner.show("Bezig met het sturen van de mail...")
            emailAddress = inputEmail.text!
            self.btnSendEmail.isEnabled = false
            
            service.forgotPassword(withSuccess: { () in
                self.btnSendEmail.isEnabled = true
                SwiftSpinner.hide()
                self.performSegue(withIdentifier: "forgotPassword", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnSendEmail.isEnabled = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andEmail: emailAddress)
        }
        else
        {
            emailDidEndEditing(inputEmail)
        }
    }
    
    @objc func emailDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorEmail, errorText: "Email kan niet leeg zijn")
        
        // Check and set error message if the email address is not valid
        textField.setErrorMessageInvalidEmail(errorLabel: errorEmail, errorText: "Dit is geen correct emailadres")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass user to next ViewController
        if(segue.identifier == "forgotPassword")
        {
            if let viewController = segue.destination as? MyPasswordResetEmailViewController
            {
                viewController.emailAddress = emailAddress
            }
        }
    }
    
    private func initUserInterface()
    {
        txtDescription.text = "Voer uw e-mailadres in om een nieuw wachtwoord aan te vragen. "
        txtDescription.font = txtDescription.font.withSize(12)
        
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
        
        btnSendEmail.setTitle("Versturen", for: .normal)
        btnSendEmail.setTitleColor(UIColor.white, for: .normal)
        btnSendEmail.backgroundColor = UIColor(rgb: 0xE84A4A)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
