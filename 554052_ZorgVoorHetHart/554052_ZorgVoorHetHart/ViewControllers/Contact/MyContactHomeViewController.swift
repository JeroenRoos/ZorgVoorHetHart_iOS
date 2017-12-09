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
    
    let service: ContactService = ContactService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Contact"
        self.hideKeyboardWhenTappedAround()
        
        txtTitle.text = "Stuur een bericht naar uw consulent"
        txtTitle.font = txtTitle.font.withSize(12)
        
        txtOnderwerp.text = "Onderwerp"
        txtOnderwerp.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputOnderwerp.placeholder = ""
        inputOnderwerp.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputOnderwerp.layer.borderWidth = 0
        inputOnderwerp.addTarget(self, action: #selector(subjectDidEndEditing(_:)), for: .editingDidEnd)
        self.inputOnderwerp.delegate = self
        
        errorOnderwerp.textColor = UIColor.red
        errorOnderwerp.font = errorOnderwerp.font.withSize(10)
        errorOnderwerp.isHidden = true
        
        txtBericht.text = "Bericht"
        txtBericht.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputBericht.placeholder = ""
        inputBericht.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputBericht.layer.borderWidth = 0
        inputBericht.addTarget(self, action: #selector(messageDidEndEditing(_:)), for: .editingDidEnd)
        self.inputBericht.delegate = self
        
        errorBericht.textColor = UIColor.red
        errorBericht.font = errorBericht.font.withSize(10)
        errorBericht.isHidden = true
        
        btnSend.setTitle("Verzenden", for: .normal)
        btnSend.setTitleColor(UIColor.white, for: .normal)
        btnSend.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnCancel.setTitle("Annuleren", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.backgroundColor = UIColor(rgb: 0xA9A9A9)
    }
    
    @IBAction func btnCancel_OnClick(_ sender: Any)
    {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func btnSend_OnClick(_ sender: Any)
    {
        var doRequest = true
        var subject: String? = nil
        var message: String? = nil
        
        if (!(inputBericht.text?.isEmpty)! && !(inputOnderwerp.text?.isEmpty)!)
        {
            subject = inputOnderwerp.text
            message = inputBericht.text
        }
        else
        {
            doRequest = false
        }
        
        if (doRequest)
        {
            service.sendMessage(withSuccess: { (message: String) in
                self.performSegue(withIdentifier: "send", sender: self)
            }, orFailure: { (error: String) in
                
            }, andSubject: subject!, andMessage: message!, andUserId: (User.loggedinUser?.userId)!)
        }
    }
    
    @objc func subjectDidEndEditing(_ textField: UITextField)
    {
        errorOnderwerp.isHidden = false
        if ((textField.text?.isEmpty)!)
        {
            errorOnderwerp.text = "Onderwerp kan niet leeg zijn"
        }
        else
        {
            errorOnderwerp.isHidden = true
        }
    }
    
    @objc func messageDidEndEditing(_ textField: UITextField)
    {
        errorBericht.isHidden = false
        if ((textField.text?.isEmpty)!)
        {
            errorBericht.text = "Bericht kan niet leeg zijn"
        }
        else
        {
            errorBericht.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
