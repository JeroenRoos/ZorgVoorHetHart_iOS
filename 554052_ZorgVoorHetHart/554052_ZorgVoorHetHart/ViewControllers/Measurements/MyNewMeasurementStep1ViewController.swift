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
    @IBOutlet weak var errorBovendruk: UILabel!
    @IBOutlet weak var errorOnderdruk: UILabel!
    
    @IBOutlet weak var btnContinuePopup: UIButton!
    @IBOutlet weak var btnCancelPopup: UIButton!
    @IBOutlet weak var txtGewicht: UILabel!
    @IBOutlet weak var txtLengte: UILabel!
    @IBOutlet weak var txtTitlePopup: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var inputLengte: UITextField!
    @IBOutlet weak var inputGewicht: UITextField!
    @IBOutlet weak var imgMiddelSquare: UIImageView!
    
    private let service: UserService = UserService()
    var measurement: Measurement? = nil
    var editingMeasurement: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }
    
    // Called when the user pressed the "Volgende" button, this method wil check all the user input and determine the validity
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        // Check all the user input for valid values
        if (!(inputOnderdruk.text?.isEmpty)! &&
            !(inputBovendruk.text?.isEmpty)! &&
            inputBovendruk.isValidNumberInput(minValue: 60, maxValue: 230) &&
            inputOnderdruk.isValidNumberInput(minValue: 30, maxValue: 180))
        {
            // Put the bloodpressure values in the Measurement
            measurement?.bloodPressureLower = Int(inputOnderdruk.text!)!
            measurement?.bloodPressureUpper = Int(inputBovendruk.text!)!
            
            // Perform the segue to the next ViewController
            self.performSegue(withIdentifier: "measurementNext", sender: self)
        }
        else
        {
            // If the input isn't valid, go through all the checks for each input field, this wil display the error message if this wasn't already the case
            bovendrukDidEndEditing(inputBovendruk)
            onderdrukDidEndEditing(inputOnderdruk)
        }
    }
    
    // Prepare the data for the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Identify the segue
        if(segue.identifier == "measurementNext")
        {
            if let viewController = segue.destination as? MyNewMeasurementStep2ViewController
            {
                viewController.measurement = measurement
                viewController.editingMeasurement = editingMeasurement
            }
        }
    }
    
    @objc func bovendrukDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorBovendruk, andText: "Bovendruk kan niet leeg zijn")
        
        textField.setErrorMessageInvalidBloodPressureUpper(withLabel: errorBovendruk, andText: "Geen geldige waarde")
    }
    
    @objc func onderdrukDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorOnderdruk, andText: "Onderdruk kan niet leeg zijn")
        
        textField.setErrorMessageInvalidBloodPressureLower(withLabel: errorOnderdruk, andText: "Geen geldige waarde")
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
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
        
        txtDate.font = txtDate.font.withSize(12)
        
        txtTitle.text = "Vul uw bloeddruk in"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
        
        txtBovendruk.text = "Bovendruk / SYS"
        txtBovendruk.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        txtOnderdruk.text = "Onderdruk / DIA"
        txtOnderdruk.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        errorBovendruk.textColor = UIColor.red
        errorBovendruk.font = errorBovendruk.font.withSize(10)
        errorBovendruk.isHidden = true
        
        inputBovendruk.placeholder = "0"
        inputBovendruk.placeholderTextColor = UIColor.gray
        inputBovendruk.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputBovendruk.layer.borderWidth = 0
        inputBovendruk.keyboardType = UIKeyboardType.numberPad
        inputBovendruk.addTarget(self, action: #selector(bovendrukDidEndEditing(_:)), for: .editingDidEnd)
        self.inputBovendruk.delegate = self
        inputBovendruk.layer.borderColor = UIColor.red.cgColor
        
        errorOnderdruk.textColor = UIColor.red
        errorOnderdruk.font = errorOnderdruk.font.withSize(10)
        errorOnderdruk.isHidden = true
        
        inputOnderdruk.placeholder = "0"
        inputOnderdruk.placeholderTextColor = UIColor.gray
        inputOnderdruk.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputOnderdruk.layer.borderWidth = 0
        inputOnderdruk.keyboardType = UIKeyboardType.numberPad
        inputOnderdruk.addTarget(self, action: #selector(onderdrukDidEndEditing(_:)), for: .editingDidEnd)
        self.inputOnderdruk.delegate = self
        inputOnderdruk.layer.borderColor = UIColor.red.cgColor
        
        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        if (measurement == nil)
        {
            measurement = Measurement()
            txtDate.text = "Datum: " + (Date().getCurrentWeekdayAndDate())!
            self.title = "Nieuwe meting: stap 1 van 2"
        }
        else
        {
            inputBovendruk.text = String((measurement?.bloodPressureUpper)!)
            inputOnderdruk.text = String((measurement?.bloodPressureLower)!)
            txtDate.text = "Datum originele meting: " + (self.measurement?.measurementDateTimeFormatted)!
            editingMeasurement = true
            self.title = "Meting bewerken: stap 1 van 2"
        }
        
        // Voor nu wordt lengte en gewicht verplaatst naar registreren
        self.btnContinuePopup.isHidden = true
        self.btnCancelPopup.isHidden = true
        self.txtGewicht.isHidden = true
        self.txtLengte.isHidden = true
        self.txtTitlePopup.isHidden = true
        self.backgroundImage.isHidden = true
        self.inputLengte.isHidden = true
        self.inputGewicht.isHidden = true
        self.imgMiddelSquare.isHidden = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





/* Voor nu wordt lengte en gewicht verplaatst naar registreren
 @IBAction func btnCancelPopup_OnClick(_ sender: Any)
 {
 self.navigationController?.popViewController(animated: true)
 }
 
 @IBAction func btnContinuePopup_OnClick(_ sender: Any)
 {
 let weight = Int(inputGewicht.text!)
 let length = Int(inputLengte.text!)
 
 service.updateLengthAndWeight(
 withSuccess: { (message: String) in
 self.btnContinuePopup.isHidden = true
 self.btnCancelPopup.isHidden = true
 self.txtGewicht.isHidden = true
 self.txtLengte.isHidden = true
 self.txtTitlePopup.isHidden = true
 self.backgroundImage.isHidden = true
 self.inputLengte.isHidden = true
 self.inputGewicht.isHidden = true
 self.imgMiddelSquare.isHidden = true
 }, orFailure: { (error: String) in
 // Failure
 }, andLength: length!, andWeight: weight!)
 }
 */
