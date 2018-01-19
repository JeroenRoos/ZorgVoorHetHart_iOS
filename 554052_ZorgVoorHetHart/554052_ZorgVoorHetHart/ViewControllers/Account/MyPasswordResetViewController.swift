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
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }

    // Called when the user pressed the "Stuur email" button, this method wil check all the user input and determine the validity
    @IBAction func btnSendEmail_OnClick(_ sender: Any)
    {
        // Check if the user input is valid
        if (!(inputEmail.text?.isEmpty)! &&
            inputEmail.isValidEmail())
        {
            SwiftSpinner.show("Bezig met het sturen van de mail...")
            emailAddress = inputEmail.text!
            self.btnSendEmail.isEnabled = false
            
            // Make the forgot password network request with a success or failure callback
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
            // If the input isn't valid, go through the check for the input field, this wil display the error message if this wasn't already the case
            emailDidEndEditing(inputEmail)
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
    
    // Prepare the data for the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Identify the ViewController
        if(segue.identifier == "forgotPassword")
        {
            // Pass the emailaddress to the next ViewController
            if let viewController = segue.destination as? MyPasswordResetEmailViewController
            {
                viewController.emailAddress = emailAddress
            }
        }
    }
    
    // Initialize the User Interface for this ViewController
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
