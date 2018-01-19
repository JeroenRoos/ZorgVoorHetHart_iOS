//
//  ContactHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import SwiftSpinner

class MyContactHomeViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtOnderwerp: UILabel!
    @IBOutlet weak var inputOnderwerp: UITextField!
    @IBOutlet weak var inputBericht: UITextField!
    @IBOutlet weak var txtBericht: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var errorOnderwerp: UILabel!
    @IBOutlet weak var errorBericht: UILabel!
    @IBOutlet weak var txtConsultantInfo: UILabel!
    
    private let service: ContactService = ContactService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Contact"
        self.hideKeyboardWhenTappedAround()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }
    
    // Reset the text of the input fields
    override func viewWillAppear(_ animated: Bool)
    {
        inputBericht.text = ""
        inputOnderwerp.text = ""
    }
    
    // Called when the user pressed the "Login" button, this method wil check all the user input and determine the validity
    @IBAction func btnSend_OnClick(_ sender: Any)
    {
        // Determine if the input from the inputfields is valid
        if (!(inputBericht.text?.isEmpty)!
            && !(inputOnderwerp.text?.isEmpty)!)
        {
            SwiftSpinner.show("Bezig met het versturen van uw bericht...")
            let subject = inputOnderwerp.text
            let message = inputBericht.text
            self.btnSend.isEnabled = false
            
            // The network request to send the message
            service.sendMessage(withSuccess: { () in
                self.btnSend.isEnabled = true
                SwiftSpinner.hide()
                self.performSegue(withIdentifier: "send", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnSend.isEnabled = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andSubject: subject!, andMessage: message!)
        }
        else
        {
            // If the input isn't valid, go through all the checks for each input field, this wil display the error message if this wasn't already the case
            subjectDidEndEditing(inputOnderwerp)
            messageDidEndEditing(inputBericht)
        }
    }
    
    // The function that will be called when the user stops editing the subject input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func subjectDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorOnderwerp, andText: "Onderwerp kan niet leeg zijn")
    }
    
    // The function that will be called when the user stops editing the message input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func messageDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorBericht, andText: "Bericht kan niet leeg zijn")
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        txtTitle.text = "Heeft u vragen of wilt u een afspraak maken? Dan kunt u via dit formulier een bericht sturen naar uw consulent. In geval van spoed kunt u het best telefonisch contact opnemen met uw ziekenhuis of 112 bellen"
        txtTitle.font = txtTitle.font.withSize(12)
        
        txtOnderwerp.text = "Onderwerp"
        txtOnderwerp.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        txtOnderwerp.isHidden = true
        
        inputOnderwerp.placeholder = "Vul een onderwerp in"
        inputOnderwerp.placeholderTextColor = UIColor.gray
        inputOnderwerp.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputOnderwerp.layer.borderWidth = 0
        inputOnderwerp.addTarget(self, action: #selector(subjectDidEndEditing(_:)), for: .editingDidEnd)
        self.inputOnderwerp.delegate = self
        inputOnderwerp.layer.borderColor = UIColor.red.cgColor
        
        errorOnderwerp.textColor = UIColor.red
        errorOnderwerp.font = errorOnderwerp.font.withSize(10)
        errorOnderwerp.isHidden = true
        
        txtBericht.text = "Bericht"
        txtBericht.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        txtBericht.isHidden = true
        
        inputBericht.placeholder = "Schrijf hier uw bericht"
        inputBericht.placeholderTextColor = UIColor.gray
        inputBericht.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputBericht.layer.borderWidth = 0
        inputBericht.addTarget(self, action: #selector(messageDidEndEditing(_:)), for: .editingDidEnd)
        self.inputBericht.delegate = self
        inputBericht.layer.borderColor = UIColor.red.cgColor
        
        errorBericht.textColor = UIColor.red
        errorBericht.font = errorBericht.font.withSize(10)
        errorBericht.isHidden = true
        
        btnSend.setTitle("Verzenden", for: .normal)
        btnSend.setTitleColor(UIColor.white, for: .normal)
        btnSend.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        let name = (User.loggedinUser?.consultant?.firstName)! + " " + (User.loggedinUser?.consultant?.lastName)!
        let email = User.loggedinUser?.consultant?.emailAddress
        txtConsultantInfo.text = "Consulent: " + name + "\nE-mail: " + email!
        txtConsultantInfo.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
