//
//  CheckboxHelper.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Helper used to make a checkbox with a button
class CheckboxHelper: UIButton
{
    // Set the images for the checked/unchecked states
    let checkedImage = UIImage(named: "ic_check_box")! as UIImage
    let uncheckedImage = UIImage(named: "ic_check_box_outline_blank")! as UIImage
    
    // A boolean property that sets the correct image for each state and can be used to determine if a checkbox is checked
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
    
    override func awakeFromNib()
    {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    // Called when a checkbox is clicked
    @objc func buttonClicked(sender: UIButton)
    {
        if sender == self
        {
            isChecked = !isChecked
        }
    }
}
