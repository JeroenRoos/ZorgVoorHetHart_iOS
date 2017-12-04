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
        self.inputOnderwerp.delegate = self
        
        txtBericht.text = "Bericht"
        txtBericht.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputBericht.placeholder = ""
        inputBericht.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputBericht.layer.borderWidth = 0
        self.inputBericht.delegate = self
        
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
        
        self.performSegue(withIdentifier: "send", sender: self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
