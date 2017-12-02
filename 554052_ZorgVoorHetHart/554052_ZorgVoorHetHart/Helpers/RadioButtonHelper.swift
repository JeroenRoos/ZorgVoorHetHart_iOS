//
//  RadioButtonHelper.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class RadioButtonHelper: UIButton
{
    var alternateButton:Array<RadioButtonHelper>?
    let checkedImage = UIImage(named: "ic_radio_button_checked")! as UIImage
    let uncheckedImage = UIImage(named: "ic_radio_button_unchecked")! as UIImage
    
    // Bool property
    var isChecked: Bool = false
    {
        didSet
        {
            if isChecked == true
            {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else
            {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    func unselectAlternateButtons()
    {
        if alternateButton != nil
        {
            self.isChecked = true
            
            for aButton:RadioButtonHelper in alternateButton!
            {
                aButton.isChecked = false
            }
        } else
        {
            toggleButton()
        }
    }
    
    override func awakeFromNib()
    {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton)
    {
        if sender == self
        {
            unselectAlternateButtons()
            //isChecked = !isChecked
        }
    }
    
    func toggleButton()
    {
        isChecked = !isChecked
    }
}
