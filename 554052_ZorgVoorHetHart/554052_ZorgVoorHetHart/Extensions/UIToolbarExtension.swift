//
//  UIToolbarExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 15/01/2018.
//  Copyright © 2018 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension for UIToolbar which adds a "Klaar" button to the toolbar. Used during the date of birth DatePicker during Registering an account
extension UIToolbar
{
    func toolbarPiker(mySelect: Selector) -> UIToolbar
    {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Klaar", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        toolbar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }
}
