//
//  MyRegisterStep1ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyRegisterStep1ViewController: UIViewController, UITextFieldDelegate
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 1 van 3"
        self.hideKeyboardWhenTappedAround()

        // Initialize the User Interface for this ViewController
        initUserInterface()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Called when the user pressed the "Volgende" button, this method wil check all the user input and determine the validity
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        // Check all the input fields for valid input
        if (!(inputName.text?.isEmpty)! &&
            !(inputDatefOfBirth.text?.isEmpty)! &&
            inputName.isValidName() &&
            !(inputLengte.text?.isEmpty)! &&
            !(inputGewicht.text?.isEmpty)! &&
            inputLengte.isValidNumberInput(minValue: 67, maxValue: 251) &&
            inputGewicht.isValidNumberInput(minValue: 30, maxValue: 594))
        {
            // Split the name textfield to get and first- and lastname
            let fullName = inputName.text!
            let fullnameArray = fullName.split(separator: " ", maxSplits: 1).map(String.init)

            // Get the date of birth from the input field
            let dateOfBirthString = inputDatefOfBirth.text
            
            // Determine the gender of the user
            if (radioButtonMan.isChecked)
            {
                user.gender = 1
            }
            else
            {
                user.gender = 2
            }
            
            // Give the user the proper values
            user.dateOfBirth = dateOfBirthString!
            user.firstName = fullnameArray[0]
            user.lastName = fullnameArray[1]
            user.length = Int(inputLengte.text!)!
            user.weight = Int(inputGewicht.text!)!
            
            // Perform a segue to the next step in the register process
            self.performSegue(withIdentifier: "registerNext", sender: self)
        }
        else
        {
            // If the input isn't valid, go through all the checks for each input field, this wil display the error message if this wasn't already the case
            nameDidEndEditing(inputName)
            dateOfBirthDidEndEditing(inputDatefOfBirth)
            lengteDidEndEditing(inputLengte)
            gewichtDidEndEditing(inputGewicht)
        }
    }
    
    // Before the segue is actualy performed, prepare the data in the next ViewController. In this case pass the user to the next ViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Identify the segue
        if(segue.identifier == "registerNext")
        {
            // Identiy the next ViewController
            if let viewController = segue.destination as? MyRegisterStep2ViewController
            {
                // Pass the user value to the next ViewController
                viewController.user = user
            }
        }
    }
    
    // The function that will be called when the user stops editing the name input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func nameDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorName, andText: "Naam kan niet leeg zijn")
        
        // Check and set error message if the name is not valid
        textField.setErrorMessageInvalidName(withLabel: errorName, andText: "Voer uw voor- en achternaam in")
    }
    
    // The function that will be called when the user stops editing the name input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func dateOfBirthDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorDateOfBirth, andText: "Geboortedatum kan niet leeg zijn")
        
        // Check and set error message if the textfield is empty
        textField.setErrorMessageInvalidDateOfBirth(withLabel: errorDateOfBirth, andText: "Geboortedatum kan niet in de toekomst zijn")
    }
    
    // The function that will be called when the user stops editing the length input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func lengteDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorLengte, andText: "Lengte kan niet leeg zijn")
        
        // Check and set error message if the length is not valid
        textField.setErrorMessageInvalidLength(withLabel: errorLengte, andText: "Lengte heeft geen geldige waarde")
    }
    
    // The function that will be called when the user stops editing the weight input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func gewichtDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorGewicht, andText: "Gewicht kan niet leeg zijn")
        
        // Check and set error message if the weight is not valid
        textField.setErrorMessageInvalidWeight(withLabel: errorGewicht, andText: "Gewicht heeft geen geldige waarde")
    }
    
    // Initialize the date of birht DatePicker
    @IBAction func inputDateofBirth_EditDidBegin(_ sender: UITextField)
    {
        // Choose the right settings and set the maximum date to today
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.maximumDate = Date()
        
        // Make the toolbar and add an "Klaar" button, the rest of the code will be performed in the ToolbarExtension
        let toolbar = UIToolbar().toolbarPiker(mySelect: #selector(dismissDatePicker))
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolbar
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    // Dismiss the DatePicker if the "Klaar" button is pressed
    @objc func dismissDatePicker()
    {
        view.endEditing(true)
    }
    
    // Set the text of the input field is the date picker value is changed
    @objc func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        let dateOfBirth = dateFormatter.string(from: sender.date)
        
        // Make sure the text is in the right format
        let finalDate = dateOfBirth.replacingOccurrences(of: "/", with: "-")
        inputDatefOfBirth.text = finalDate
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
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
        inputDatefOfBirth.placeholderTextColor = UIColor.gray
        inputDatefOfBirth.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputDatefOfBirth.layer.borderWidth = 0
        inputDatefOfBirth.addTarget(self, action: #selector(dateOfBirthDidEndEditing(_:)), for: .editingDidEnd)
        self.inputDatefOfBirth.delegate = self
        inputDatefOfBirth.layer.borderColor = UIColor.red.cgColor
        
        errorName.textColor = UIColor.red
        errorName.font = errorName.font.withSize(10)
        errorName.isHidden = true
        
        inputName.placeholder = "Vul uw naam in"
        inputName.placeholderTextColor = UIColor.gray
        inputName.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputName.layer.borderWidth = 0
        self.inputName.delegate = self
        inputName.addTarget(self, action: #selector(nameDidEndEditing(_:)), for: .editingDidEnd)
        inputName.layer.borderColor = UIColor.red.cgColor
        
        errorLengte.textColor = UIColor.red
        errorLengte.font = errorLengte.font.withSize(10)
        errorLengte.isHidden = true
        
        inputLengte.placeholder = "Vul uw lengte in (cm)"
        inputLengte.placeholderTextColor = UIColor.gray
        inputLengte.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputLengte.layer.borderWidth = 0
        inputLengte.keyboardType = UIKeyboardType.numberPad
        self.inputLengte.delegate = self
        inputLengte.addTarget(self, action: #selector(lengteDidEndEditing(_:)), for: .editingDidEnd)
        inputLengte.layer.borderColor = UIColor.red.cgColor
        
        errorGewicht.textColor = UIColor.red
        errorGewicht.font = errorGewicht.font.withSize(10)
        errorGewicht.isHidden = true
        
        inputGewicht.placeholder = "Vul uw gewicht in (KG)"
        inputGewicht.placeholderTextColor = UIColor.gray
        inputGewicht.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputGewicht.layer.borderWidth = 0
        inputGewicht.keyboardType = UIKeyboardType.numberPad
        self.inputGewicht.delegate = self
        inputGewicht.addTarget(self, action: #selector(gewichtDidEndEditing(_:)), for: .editingDidEnd)
        inputGewicht.layer.borderColor = UIColor.red.cgColor
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
