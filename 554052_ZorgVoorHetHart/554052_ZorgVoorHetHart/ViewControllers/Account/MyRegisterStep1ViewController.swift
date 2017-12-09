//
//  MyRegisterStep1ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Dropper

class MyRegisterStep1ViewController: UIViewController, UITextFieldDelegate, DropperDelegate
{
    @IBOutlet weak var testBtn: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var radioButtonWoman: RadioButtonHelper!
    @IBOutlet weak var radioButtonMan: RadioButtonHelper!
    @IBOutlet weak var txtGender: UILabel!
    @IBOutlet weak var inputDatefOfBirth: UITextField!
    @IBOutlet weak var inputName: UITextField!
    
    @IBOutlet weak var dropdown: UIButton!
    private let decoder = JSONDecoder()
    private var user: User? = nil
    private var dropper: Dropper? = nil
    private var lstConsultants : [Consultant] = []
    private var lstConsultantsNames : [String] = []
    
    let service: ConsultantsService = ConsultantsService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 1 van 2"
        self.hideKeyboardWhenTappedAround()
        user = User()
        
        dropdown.setTitle("  Selecteer uw consulent", for: .normal)
        dropdown.backgroundColor = UIColor(rgb: 0xEBEBEB)
        dropdown.setTitleColor(UIColor.gray, for: .normal)
        dropdown.layer.cornerRadius = 5
        dropdown.contentHorizontalAlignment = .left
        dropdown.isHidden = true
        
        // https://github.com/kirkbyo/Dropper
        dropper = Dropper(width: dropdown.frame.width - 40, height: 300)

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
        self.inputDatefOfBirth.delegate = self
        
        inputName.placeholder = "Vul uw naam in"
        inputName.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputName.layer.borderWidth = 0
        self.inputName.delegate = self
        
        fetchConsultants()
    }
    
    private func fetchConsultants()
    {
        service.getConsultans(
            withSuccess: { (consultants: [Consultant]) in
                self.dropdown.isHidden = false
                self.lstConsultants = consultants
                self.getConsultantsNames()
        }, orFailure: { (error: String) in
                // Failure
        })
        
    }
    
    private func getConsultantsNames()
    {
        for var index in 0 ..< lstConsultants.count
        {
            let name = lstConsultants[index].firstName
                + " " + lstConsultants[index].lastName
            self.lstConsultantsNames.append(name) //= name
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DropdownAction(_ sender: Any)
    {
        dropper?.delegate = self
        dropper?.cornerRadius = 5
        dropper?.items = lstConsultantsNames
        dropper?.maxHeight = 400
        dropper?.showWithAnimation(0.15, options: Dropper.Alignment.center, button: dropdown)
    }
    
    func DropperSelectedRow(_ path: IndexPath, contents: String, tag: Int)
    {
        let consultant = lstConsultantsNames[path.row]
        dropdown.setTitle("  " + consultant, for: .normal)
        
        for var index in 0 ..< lstConsultants.count
        {
            let name = lstConsultants[index].firstName
                + " " + lstConsultants[index].lastName
            if (consultant == name)
            {
                user?.consultantId = lstConsultants[index].consultantId
            }
        }
    }
    
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        let fullName = inputName.text!
        let fullnameArray = fullName.split(separator: " ", maxSplits: 1).map(String.init)
        user?.firstName = fullnameArray[0]
        user?.lastName = fullnameArray[1]
        
        let dateOfBirthString = inputDatefOfBirth.text
        user?.dateOfBirth = dateOfBirthString!
        
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
