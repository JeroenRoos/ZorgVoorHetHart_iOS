//
//  UIViewControllerExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 04/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension of UIViewController to have some function available in all ViewControllers
extension UIViewController
{
    // Hides the keyboard when you tap anywhere on the screen
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return false
    }
    
    // Shows an alertbox in the Viewcontroller with a message and title
    func showAlertBox(withMessage message: String, andTitle title: String)
    {
        DispatchQueue.main.async() {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
