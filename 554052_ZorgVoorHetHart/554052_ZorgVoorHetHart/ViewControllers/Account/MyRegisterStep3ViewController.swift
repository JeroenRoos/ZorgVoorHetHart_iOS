//
//  MyRegisterStep3ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 19/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyRegisterStep3ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var inputGewicht: UITextField!
    @IBOutlet weak var inputLengte: UITextField!
    @IBOutlet weak var errorLengte: UILabel!
    @IBOutlet weak var errorGewicht: UILabel!
    
    private let service: UserService = UserService()
    var user: User? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 3 van 3"
        self.hideKeyboardWhenTappedAround()
        
        btnFinish.setTitle("Afronden", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        errorLengte.textColor = UIColor.red
        errorLengte.font = errorLengte.font.withSize(10)
        errorLengte.isHidden = true
        
        inputLengte.placeholder = "Vul uw lengte in (cm)"
        inputLengte.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputLengte.layer.borderWidth = 0
        inputLengte.keyboardType = UIKeyboardType.numberPad
        self.inputLengte.delegate = self
        inputLengte.addTarget(self, action: #selector(lengteDidEndEditing(_:)), for: .editingDidEnd)
        
        errorGewicht.textColor = UIColor.red
        errorGewicht.font = errorGewicht.font.withSize(10)
        errorGewicht.isHidden = true
        
        inputGewicht.placeholder = "Vul uw gewicht in (KG)"
        inputGewicht.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputGewicht.layer.borderWidth = 0
        inputGewicht.keyboardType = UIKeyboardType.numberPad
        self.inputGewicht.delegate = self
        inputGewicht.addTarget(self, action: #selector(gewichtDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @objc func lengteDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorLengte, errorText: "Lengte kan niet leeg zijn")
        
        // Check and set error message if the length is not valid
        textField.setErrorMessageInvalidLength(errorLabel: errorLengte, errorText: "Lengte heeft geen geldige waarde")
    }
    
    @objc func gewichtDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorGewicht, errorText: "Gewicht kan niet leeg zijn")
        
        // Check and set error message if the weight is not valid
        textField.setErrorMessageInvalidWeight(errorLabel: errorGewicht, errorText: "Gewicht heeft geen geldige waarde")
    }
    
    // registerFinish
    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
        if (!(inputLengte.text?.isEmpty)! &&
            !(inputGewicht.text?.isEmpty)! &&
            inputLengte.isValidNumberInput(minValue: 67, maxValue: 251) &&
            inputGewicht.isValidNumberInput(minValue: 30, maxValue: 594))
        {
            user?.length = Int(inputLengte.text!)!
            user?.weight = Int(inputGewicht.text!)!
            
            service.register(withSuccess: { (message: String) in
                self.performSegue(withIdentifier: "registerFinish", sender: self)
            }, orFailure: { (error: String) in
                
            }, andUser: user!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass user to next ViewController
        if(segue.identifier == "registerFinish")
        {
            if let viewController = segue.destination as? MyRegisterFinishedViewController
            {
                viewController.user = user
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
