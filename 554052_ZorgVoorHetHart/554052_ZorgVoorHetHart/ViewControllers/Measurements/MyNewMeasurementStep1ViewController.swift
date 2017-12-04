//
//  MyNewMeasurementStep1ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 25/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyNewMeasurementStep1ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var inputOnderdruk: UITextField!
    @IBOutlet weak var txtOnderdruk: UILabel!
    @IBOutlet weak var inputBovendruk: UITextField!
    @IBOutlet weak var txtBovendruk: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnContinuePopup: UIButton!
    @IBOutlet weak var btnCancelPopup: UIButton!
    @IBOutlet weak var txtGewicht: UILabel!
    @IBOutlet weak var txtLengte: UILabel!
    @IBOutlet weak var txtTitlePopup: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var inputLengte: UITextField!
    @IBOutlet weak var inputGewicht: UITextField!
    @IBOutlet weak var imgMiddelSquare: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Nieuwe meting: stap 1 van 3"
        self.hideKeyboardWhenTappedAround()
        
        backgroundImage.alpha = 0.5
        
        txtTitlePopup.text = "Goed dat u een meting wilt doen. Voordat u verder kunt gaan hebben wij echter nog enkele gegevens nodig zodat we u beter kunnen assisteren. Namelijk: "
        txtTitlePopup.font = txtTitlePopup.font.withSize(12)
        
        txtLengte.text = "Lengte (cm)"
        txtLengte.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        txtGewicht.text = "Gewicht (KG)"
        txtGewicht.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputLengte.placeholder = "0"
        inputLengte.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputLengte.layer.borderWidth = 0
        inputLengte.keyboardType = UIKeyboardType.numberPad
        self.inputLengte.delegate = self
        
        inputGewicht.placeholder = "0"
        inputGewicht.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputGewicht.layer.borderWidth = 0
        inputGewicht.keyboardType = UIKeyboardType.numberPad
        self.inputGewicht.delegate = self
        
        btnContinuePopup.setTitle("Doorgaan", for: .normal)
        btnContinuePopup.setTitleColor(UIColor.white, for: .normal)
        btnContinuePopup.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnCancelPopup.setTitle("Annuleren", for: .normal)
        btnCancelPopup.setTitleColor(UIColor.white, for: .normal)
        btnCancelPopup.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        txtDate.text = (Date().getCurrentWeekdayAndDate())
        txtDate.font = txtDate.font.withSize(12)
        
        txtTitle.text = "1. Vul uw bloeddruk in (mmHg)"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        txtBovendruk.text = "Bovendruk / SYS"
        txtBovendruk.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        txtOnderdruk.text = "Onderdruk / DIA"
        txtOnderdruk.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputBovendruk.placeholder = "0"
        inputBovendruk.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputBovendruk.layer.borderWidth = 0
        inputBovendruk.keyboardType = UIKeyboardType.numberPad
        self.inputBovendruk.delegate = self
        
        inputOnderdruk.placeholder = "0"
        inputOnderdruk.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputOnderdruk.layer.borderWidth = 0
        inputOnderdruk.keyboardType = UIKeyboardType.numberPad
        self.inputOnderdruk.delegate = self
        
        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnCancel.setTitle("Annuleren", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.backgroundColor = UIColor(rgb: 0xA9A9A9)
    }
    
    @IBAction func btnCancel_OnClick(_ sender: Any)
    {
        
        self.navigationController?.popViewController(animated: true)
        //self.performSegue(withIdentifier: "cancel", sender: self)
    }
    
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        
        self.performSegue(withIdentifier: "next", sender: self)
    }
    
    @IBAction func btnCancelPopup_OnClick(_ sender: Any)
    {
        
        self.navigationController?.popViewController(animated: true)
        //self.performSegue(withIdentifier: "cancel", sender: self)
    }
    
    @IBAction func btnContinuePopup_OnClick(_ sender: Any)
    {
        btnContinuePopup.isHidden = true
        btnCancelPopup.isHidden = true
        txtGewicht.isHidden = true
        txtLengte.isHidden = true
        txtTitlePopup.isHidden = true
        backgroundImage.isHidden = true
        inputLengte.isHidden = true
        inputGewicht.isHidden = true
        imgMiddelSquare.isHidden = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
