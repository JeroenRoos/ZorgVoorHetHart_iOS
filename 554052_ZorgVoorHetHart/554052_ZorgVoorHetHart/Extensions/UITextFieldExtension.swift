//
//  UITextFieldExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 08/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension of UITextField which makes me able to change the color of the placeholder text in an easier way and use the error handling for input fields in all ViewControllers
extension UITextField
{
    @IBInspectable var placeholderTextColor: UIColor
    {
        get { return self.placeholderTextColor }
        set
        {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: newValue])
        }
    }
    
    // Check if the inputfield text is an valid Email address
    func isValidEmail() -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
    
    // Check if the inputfield is an valid name (it needs at least 2 values because first- and lastname are in the same inputfield
    func isValidName() -> Bool
    {
        let nameArray = self.text?.split(separator: " ", maxSplits: 1).map(String.init)
        if (nameArray?.count ?? 0 <= 1)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    // Check if the number input in a textfield is valid based on a min and max value
    func isValidNumberInput(withMinValue minValue: Int, andMaxValue maxValue: Int) -> Bool
    {
        let input = Int(self.text!)!
        if input > minValue && input < maxValue
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // Check if the input field is empty and set error message if needed
    func setErrorMessageEmptyField(withLabel errorLabel: UILabel, andText errorText: String)
    {
        errorLabel.isHidden = false
        self.layer.borderWidth = 1
        
        if ((self.text?.isEmpty)!)
        {
            errorLabel.text = errorText
        }
        else
        {
            errorLabel.isHidden = true
            self.layer.borderWidth = 0

        }
    }
    
    // Check if the name is valid and set error message if needed
    func setErrorMessageInvalidName(withLabel errorLabel: UILabel, andText errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            
            if (!self.isValidName())
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    // Check if the email is valid and set error message if needed
    func setErrorMessageInvalidEmail(withLabel errorLabel: UILabel, andText errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            if (!self.isValidEmail())
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    // Check if the passwords are identical and set error message if needed
    func setErrorMessagePasswordIdentical(withLabel errorLabel: UILabel, andText errorText: String, andOtherPassword otherPassword: UITextField)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            if (self.text != otherPassword.text)
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    // Check if the weight is valid and set error message if needed
    func setErrorMessageInvalidWeight(withLabel errorLabel: UILabel, andText errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            // Heaviest man living = 594 kg
            if (!self.isValidNumberInput(withMinValue: 30, andMaxValue: 594))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    // Check if the heigh is valid and set error message if needed
    func setErrorMessageInvalidLength(withLabel errorLabel: UILabel, andText errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            // Smallest man living = 67 cm & Tallest man living = 251 cm
            if (!self.isValidNumberInput(withMinValue: 67, andMaxValue: 251))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    // Check if the bloodpressure lower is valid and set error message if needed
    func setErrorMessageInvalidBloodPressureLower(withLabel errorLabel : UILabel, andText errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            if (!self.isValidNumberInput(withMinValue: 30, andMaxValue: 180))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    // Check if the bloodpressure upper is valid and set error message if needed
    func setErrorMessageInvalidBloodPressureUpper(withLabel errorLabel: UILabel, andText errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            if (!self.isValidNumberInput(withMinValue: 60, andMaxValue: 230))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    // Check if the date of birth is valid and set error message if needed
    func setErrorMessageInvalidDateOfBirth(withLabel errorLabel: UILabel, andText errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            let dateOfBirth = self.text!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.locale = Locale(identifier: "nl_NL")
            let birthDate = dateFormatter.date(from: dateOfBirth)
            let todayDate = Date()
            
            errorLabel.isHidden = false
            self.layer.borderWidth = 1
            if (birthDate! > todayDate)
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
}
