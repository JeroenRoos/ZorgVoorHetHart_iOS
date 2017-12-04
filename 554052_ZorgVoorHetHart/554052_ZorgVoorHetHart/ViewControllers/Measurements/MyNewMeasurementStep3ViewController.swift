//
//  MyNewMeasurementStep3ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 27/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyNewMeasurementStep3ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var inputMessage: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Nieuwe meting: stap 3 van 3"
        self.hideKeyboardWhenTappedAround()
        
        txtDate.text = (Date().getCurrentWeekdayAndDate())
        txtDate.font = txtDate.font.withSize(12)
        
        txtTitle.text = "3. Extra / Opmerkingen"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputMessage.placeholder = ""
        inputMessage.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputMessage.layer.borderWidth = 0
        self.inputMessage.delegate = self
        
        btnSave.setTitle("Opslaan", for: .normal)
        btnSave.setTitleColor(UIColor.white, for: .normal)
        btnSave.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnBack.setTitle("Terug", for: .normal)
        btnBack.setTitleColor(UIColor.white, for: .normal)
        btnBack.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_OnClick(_ sender: Any)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave_OnClick(_ sender: Any)
    {
        
        self.performSegue(withIdentifier: "save", sender: self)
    }

}
