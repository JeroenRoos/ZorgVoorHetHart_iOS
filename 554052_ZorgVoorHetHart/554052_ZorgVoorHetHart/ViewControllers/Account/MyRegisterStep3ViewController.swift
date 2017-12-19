//
//  MyRegisterStep3ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 19/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyRegisterStep3ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var inputGewicht: UITextField!
    @IBOutlet weak var inputLengte: UITextField!
    
    private let service: UserService = UserService()
    var user: User? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 3 van 3"
        self.hideKeyboardWhenTappedAround()
        
        btnFinish.setTitle("Afronden", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        inputLengte.placeholder = "Vul uw lengte in"
        inputLengte.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputLengte.layer.borderWidth = 0
        inputLengte.keyboardType = UIKeyboardType.numberPad
        self.inputLengte.delegate = self
        inputLengte.addTarget(self, action: #selector(lengteDidEndEditing(_:)), for: .editingDidEnd)
        
        inputGewicht.placeholder = "Vul uw gewicht in"
        inputGewicht.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputGewicht.layer.borderWidth = 0
        inputGewicht.keyboardType = UIKeyboardType.numberPad
        self.inputGewicht.delegate = self
        inputGewicht.addTarget(self, action: #selector(gewichtDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @objc func lengteDidEndEditing(_ textField: UITextField)
    {
        
    }
    
    @objc func gewichtDidEndEditing(_ textField: UITextField)
    {
        
    }
    
    // registerFinish
    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
     
        
        service.register(withSuccess: { (message: String) in
            self.performSegue(withIdentifier: "registerFinish", sender: self)
        }, orFailure: { (error: String) in
            
        }, andUser: user!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass user to next ViewController
        if(segue.identifier == "registerFinish")
        {
            if let viewController = segue.destination as? MyRegisterFinishedViewController
            {
                viewController.user = user
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
