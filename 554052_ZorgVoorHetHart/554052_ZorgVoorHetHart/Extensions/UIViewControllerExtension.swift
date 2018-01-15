//
//  UIViewControllerExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 04/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

extension UIViewController
{
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
    
    func showAlertBox(withMessage message: String, andTitle title: String)
    {
        
        //var shouldRetry = false
        DispatchQueue.main.async() {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        //return shouldRetry
    }
}
