//
//  ContactHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyContactHomeViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtOnderwerp: UILabel!
    @IBOutlet weak var inputOnderwerp: UITextField!
    @IBOutlet weak var inputBericht: UITextField!
    @IBOutlet weak var txtBericht: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
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
        
        txtTitle.text = "Heeft u vragen of wilt u een afspraak maken? Dan kunt u via dit formulier een bericht sturen naar uw consulent. In geval van spoed kunt u het best telefonisch contact opnemen met uw ziekenhuis of 112 bellen"
        txtTitle.font = txtTitle.font.withSize(12)
        
        txtOnderwerp.text = "Onderwerp"
        txtOnderwerp.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        txtOnderwerp.isHidden = true
        
        inputOnderwerp.placeholder = "Vul een onderwerp in"
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
        
        btnCancel.setTitle("Annuleren", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        let name = (User.loggedinUser?.consultant?.firstName)! + " " + (User.loggedinUser?.consultant?.lastName)!
        let email = User.loggedinUser?.consultant?.emailAddress
        txtConsultantInfo.text = "Uw bericht wordt verstuurd naar: " + name + " - " + email!
        txtConsultantInfo.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        inputBericht.text = ""
        inputOnderwerp.text = ""
    }
    
    @IBAction func btnCancel_OnClick(_ sender: Any)
    {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func btnSend_OnClick(_ sender: Any)
    {
        if (!(inputBericht.text?.isEmpty)!
            && !(inputOnderwerp.text?.isEmpty)!)
        {
            let subject = inputOnderwerp.text
            let message = inputBericht.text
            self.btnSend.isEnabled = false
            
            service.sendMessage(withSuccess: { () in
                self.btnSend.isEnabled = true
                self.performSegue(withIdentifier: "send", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnSend.isEnabled = true
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andSubject: subject!, andMessage: message!)
        }
    }
    
    @objc func subjectDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorOnderwerp, errorText: "Onderwerp kan niet leeg zijn")
    }
    
    @objc func messageDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorBericht, errorText: "Bericht kan niet leeg zijn")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
