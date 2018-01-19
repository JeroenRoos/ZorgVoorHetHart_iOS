//
//  RadioButtonHelper.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Helper used to make a checkbox with a button
class RadioButtonHelper: UIButton
{
    var alternateButton:Array<RadioButtonHelper>?
    let checkedImage = UIImage(named: "ic_radio_button_checked")! as UIImage
    let uncheckedImage = UIImage(named: "ic_radio_button_unchecked")! as UIImage
    
    // A boolean property that sets the correct image for each state and can be used to determine if a radiobutton is checked
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
    
    // Only one radio button can be selected, this unselects the other radio buttons when the users selects a button
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
        }
    }
    
    func toggleButton()
    {
        isChecked = !isChecked
    }
}
