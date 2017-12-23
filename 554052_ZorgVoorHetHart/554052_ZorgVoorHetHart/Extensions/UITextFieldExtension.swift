//
//  UITextFieldExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 08/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
//private var xoAssociationKey: UInt8 = 0

extension UITextField
{
    
    func isValidEmail() -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
    
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
    
    func isValidNumberInput(minValue: Int, maxValue: Int) -> Bool
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
    
    func setErrorMessageEmptyField(errorLabel: UILabel, errorText: String)
    {
        errorLabel.isHidden = false
        if ((self.text?.isEmpty)!)
        {
            errorLabel.text = errorText
        }
        else
        {
            errorLabel.isHidden = true
        }
    }
    
    func setErrorMessageInvalidName(errorLabel: UILabel, errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            if (!self.isValidName())
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
            }
        }
    }
    
    func setErrorMessageInvalidEmail(errorLabel: UILabel, errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            if (!self.isValidEmail())
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
            }
        }
    }
    
    func setErrorMessagePasswordIdentical(errorLabel: UILabel, errorText: String, otherPassword: UITextField)
    {
        errorLabel.isHidden = false
        if (self.text != otherPassword.text)
        {
            errorLabel.text = errorText
        }
        else
        {
            errorLabel.isHidden = true
        }
    }
    
    func setErrorMessageInvalidWeight(errorLabel: UILabel, errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            // Heaviest man living = 594 kg
            if (!self.isValidNumberInput(minValue: 30, maxValue: 594))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
            }
        }
    }
    
    func setErrorMessageInvalidLength(errorLabel: UILabel, errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            // Smallest man living = 67 cm & Tallest man living = 251 cm
            if (!self.isValidNumberInput(minValue: 67, maxValue: 251))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
            }
        }
    }
    
    func setErrorMessageInvalidBloodPressureLower(errorLabel: UILabel, errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            if (!self.isValidNumberInput(minValue: 30, maxValue: 110))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
            }
        }
    }
    
    func setErrorMessageInvalidBloodPressureUpper(errorLabel: UILabel, errorText: String)
    {
        if (!(self.text?.isEmpty)!)
        {
            errorLabel.isHidden = false
            if (!self.isValidNumberInput(minValue: 60, maxValue: 200))
            {
                errorLabel.text = errorText
            }
            else
            {
                errorLabel.isHidden = true
            }
        }
    }

}
