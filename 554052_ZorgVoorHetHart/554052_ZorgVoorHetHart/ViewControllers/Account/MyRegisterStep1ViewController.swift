//
//  MyRegisterStep1ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import DropDown

class MyRegisterStep1ViewController: UIViewController
{
    @IBOutlet weak var testBtn: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var radioButtonWoman: RadioButtonHelper!
    @IBOutlet weak var radioButtonMan: RadioButtonHelper!
    @IBOutlet weak var txtGender: UILabel!
    @IBOutlet weak var inputDatefOfBirth: UITextField!
    @IBOutlet weak var inputName: UITextField!
    
    //var user = try! User(from: JSONDecoder() as! Decoder)
    let decoder = JSONDecoder()
    var user : User? = nil //= try! User(from: decoder)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 1 van 2"
        user = User()
        
        // DropDown CocaoPods & Tutorial
        // https://github.com/nahuelDeveloper/DropDown
        // https://www.raywenderlich.com/156971/cocoapods-tutorial-swift-getting-started
        /* let lstConsultans : [String] = ["", "Dhr. Pieters", "Dhr. Martens", "Dhr. van der Laan"]
        
        let dropDown = DropDown()
        // The view to which the drop down will appear on
        dropDown.anchorView = testBtn // UIView or UIBarButtonItem
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = lstConsultans
        dropDown.show() */
        
        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        txtGender.text = "Geslacht bij geboorte"
        
        radioButtonMan.setTitle("Man", for: .normal)
        radioButtonMan.setTitleColor(UIColor.black, for: .normal)
        radioButtonMan?.alternateButton = [radioButtonWoman!]
        radioButtonMan.layer.borderWidth = 0
        
        radioButtonWoman.setTitle("Vrouw", for: .normal)
        radioButtonWoman.setTitleColor(UIColor.black, for: .normal)
        radioButtonWoman?.alternateButton = [radioButtonMan!]
        radioButtonWoman.layer.borderWidth = 0
        
        inputDatefOfBirth.placeholder = "Uw geboortedatum"
        inputDatefOfBirth.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputDatefOfBirth.layer.borderWidth = 0
        
        inputName.placeholder = "Vul uw naam in"
        inputName.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputName.layer.borderWidth = 0
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        user?.firstName = inputName.text!
        user?.lastName = inputName.text!
        
        let dateOfBirthString = inputDatefOfBirth.text
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        user?.dateOfBirth = formatter.date(from: dateOfBirthString!)!
        
        if (radioButtonMan.isChecked)
        {
            user?.gender = 1
        }
        else
        {
            user?.gender = 2
        }
        
        self.performSegue(withIdentifier: "registerNext", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass user to next ViewController
        if(segue.identifier == "registerNext")
        {
            if let viewController = segue.destination as? MyRegisterStep2ViewController
            {
                viewController.user = user
            }
        }
    }
    
    @IBAction func inputDateofBirth_EditDidBegin(_ sender: UITextField)
    {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        let dateOfBirth = dateFormatter.string(from: sender.date)
        let finalDate = dateOfBirth.replacingOccurrences(of: "/", with: "-")
        inputDatefOfBirth.text = finalDate
    }
    
    override func awakeFromNib()
    {
        self.view.layoutIfNeeded()
        radioButtonWoman.isChecked = false
        radioButtonMan.isChecked = true
    }
    
    // Navigatie terug naar dit scherm
    @IBAction func unwindForm(sender: UIStoryboardSegue)
    {
        
    }
}
