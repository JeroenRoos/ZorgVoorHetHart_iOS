//
//  MyRegisterStep1ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
//import Dropper

class MyRegisterStep1ViewController: UIViewController, UITextFieldDelegate//, DropperDelegate
{
    @IBOutlet weak var testBtn: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var radioButtonWoman: RadioButtonHelper!
    @IBOutlet weak var radioButtonMan: RadioButtonHelper!
    @IBOutlet weak var txtGender: UILabel!
    @IBOutlet weak var inputDatefOfBirth: UITextField!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorDateOfBirth: UILabel!
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var inputGewicht: UITextField!
    @IBOutlet weak var inputLengte: UITextField!
    @IBOutlet weak var errorLengte: UILabel!
    @IBOutlet weak var errorGewicht: UILabel!
    private var user: User = User()
    //@IBOutlet weak var errorConsultant: UILabel!
    
    /*@IBOutlet weak var dropdown: UIButton!
    private let decoder = JSONDecoder()
    private var user: User = User()
    private var dropper: Dropper? = nil
    private var lstConsultants : [Consultant] = []
    private var lstConsultantsNames : [String] = []
    private let service: ConsultantsService = ConsultantsService() */
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 1 van 3"
        self.hideKeyboardWhenTappedAround()

        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        txtTitle.text = "Persoonsgegevens"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        txtGender.text = "Geslacht bij geboorte"
        
        radioButtonMan.setTitle("Man", for: .normal)
        radioButtonMan.setTitleColor(UIColor.black, for: .normal)
        radioButtonMan?.alternateButton = [radioButtonWoman!]
        radioButtonMan.layer.borderWidth = 0
        
        radioButtonWoman.setTitle("Vrouw", for: .normal)
        radioButtonWoman.setTitleColor(UIColor.black, for: .normal)
        radioButtonWoman?.alternateButton = [radioButtonMan!]
        radioButtonWoman.layer.borderWidth = 0
        
        errorDateOfBirth.textColor = UIColor.red
        errorDateOfBirth.font = errorDateOfBirth.font.withSize(10)
        errorDateOfBirth.isHidden = true
        
        inputDatefOfBirth.placeholder = "Uw geboortedatum"
        inputDatefOfBirth.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputDatefOfBirth.layer.borderWidth = 0
        inputDatefOfBirth.addTarget(self, action: #selector(dateOfBirthDidEndEditing(_:)), for: .editingDidEnd)
        self.inputDatefOfBirth.delegate = self
        
        errorName.textColor = UIColor.red
        errorName.font = errorName.font.withSize(10)
        errorName.isHidden = true
        
        inputName.placeholder = "Vul uw naam in"
        inputName.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputName.layer.borderWidth = 0
        self.inputName.delegate = self
        inputName.addTarget(self, action: #selector(nameDidEndEditing(_:)), for: .editingDidEnd)
        
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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        if (!(inputName.text?.isEmpty)! &&
            !(inputDatefOfBirth.text?.isEmpty)! &&
            inputName.isValidName() &&
            !(inputLengte.text?.isEmpty)! &&
            !(inputGewicht.text?.isEmpty)! &&
            inputLengte.isValidNumberInput(minValue: 67, maxValue: 251) &&
            inputGewicht.isValidNumberInput(minValue: 30, maxValue: 594))
        {
            let fullName = inputName.text!
            let fullnameArray = fullName.split(separator: " ", maxSplits: 1).map(String.init)
            user.firstName = fullnameArray[0]
            user.lastName = fullnameArray[1]
                
            let dateOfBirthString = inputDatefOfBirth.text
            user.dateOfBirth = dateOfBirthString!
                
            if (radioButtonMan.isChecked)
            {
                user.gender = 1
            }
            else
            {
                user.gender = 2
            }
            
            user.length = Int(inputLengte.text!)!
            user.weight = Int(inputGewicht.text!)!
            
            self.performSegue(withIdentifier: "registerNext", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass user to next ViewController
        if(segue.identifier == "registerNext")
        {
            if let viewController = segue.destination as? MyRegisterStep2ViewController
            {
                viewController.user = user
            }
        }
    }
    
    @objc func nameDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorName, errorText: "Naam kan niet leeg zijn")
        
        // Check and set error message if the name is not valid
        textField.setErrorMessageInvalidName(errorLabel: errorName, errorText: "Voer uw voor- en achternaam in")
    }
    
    @objc func dateOfBirthDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(errorLabel: errorDateOfBirth, errorText: "Geboortedatum kan niet leeg zijn")
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
    
    
    @IBAction func inputDateofBirth_EditDidBegin(_ sender: UITextField)
    {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        let dateOfBirth = dateFormatter.string(from: sender.date)
        let finalDate = dateOfBirth.replacingOccurrences(of: "/", with: "-")
        inputDatefOfBirth.text = finalDate
    }
    
    override func awakeFromNib()
    {
        self.view.layoutIfNeeded()
        radioButtonWoman.isChecked = false
        radioButtonMan.isChecked = true
    }
    
    // Navigatie terug naar dit scherm
    @IBAction func unwindForm(sender: UIStoryboardSegue)
    {
        
    }
}
