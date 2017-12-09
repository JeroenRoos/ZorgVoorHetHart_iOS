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
    
    /*
    var isEmailAddress : Bool?
    {
        get
        {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? Bool
        }
        set (newValue)
        {
             objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    */
}
