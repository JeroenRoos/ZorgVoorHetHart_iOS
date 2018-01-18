//
//  MyRegisterStep3ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 19/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Dropper
import SwiftSpinner

class MyRegisterStep3ViewController: UIViewController, UITextFieldDelegate, DropperDelegate
{
    @IBOutlet weak var errorConsultant: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var dropdown: UIButton!
    
    private var dropper: Dropper? = nil
    private var lstConsultants : [Consultant] = []
    private var lstConsultantsNames : [String] = []
    private let service: ConsultantsService = ConsultantsService()
    private let userService: UserService = UserService()
    var user: User? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 3 van 3"
        self.hideKeyboardWhenTappedAround()
    
        initUserInterface()
        fetchConsultants()
 }
    
    private func fetchConsultants()
    {
        SwiftSpinner.show("Bezig met het ophalen van de benodigde data...")
        service.getConsultans(
            withSuccess: { (consultants: [Consultant]) in
                self.dropdown.isHidden = false
                self.lstConsultants = consultants
                self.getConsultantsNames()
                SwiftSpinner.hide()
        }, orFailure: { (error: String, title: String) in
            self.errorConsultant.isHidden = false
            self.errorConsultant.text = "Er is iets fout gegaan bij het ophalen van de consulenten"
            self.dropper?.layer.borderWidth = 1
            SwiftSpinner.hide()
            self.showAlertBox(withMessage: error, andTitle: title)
        })
    }
    
    private func getConsultantsNames()
    {
        for index in 0 ..< lstConsultants.count
        {
            let name = lstConsultants[index].firstName
                + " " + lstConsultants[index].lastName
            self.lstConsultantsNames.append(name)
        }
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
        
        for index in 0 ..< lstConsultants.count
        {
            let name = lstConsultants[index].firstName
                + " " + lstConsultants[index].lastName
            
            if (consultant == name)
            {
                user?.consultantId = lstConsultants[index].consultantId
                errorConsultant.isHidden = true
                break
            }
        }
    }

    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
        if (!(user?.consultantId.isEmpty)!)
        {
            SwiftSpinner.show("Bezig met registreren van uw account...")
            
            self.btnFinish.isEnabled = false
            userService.register(withSuccess: { () in
                self.btnFinish.isEnabled = true
                SwiftSpinner.hide()
                self.performSegue(withIdentifier: "registerFinish", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnFinish.isEnabled = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andUser: user!)
        }
        else
        {
            errorConsultant.isHidden = false
            self.errorConsultant.text = "Uw consultent kan niet leeg zijn"
        }
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
    
    private func initUserInterface()
    {
        txtTitle.text = "Consultent"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        txtDescription.text = "Uw consulent bij het St. Antonius Ziekenhuis"
        txtDescription.font = txtDescription.font.withSize(12)
        
        btnFinish.setTitle("Afronden", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        errorConsultant.textColor = UIColor.red
        errorConsultant.font = errorConsultant.font.withSize(10)
        errorConsultant.isHidden = true
        
        dropdown.setTitle("  Selecteer uw consulent", for: .normal)
        dropdown.backgroundColor = UIColor(rgb: 0xEBEBEB)
        dropdown.setTitleColor(UIColor.gray, for: .normal)
        dropdown.layer.cornerRadius = 5
        dropdown.contentHorizontalAlignment = .left
        dropdown.isHidden = true
        dropdown.layer.borderColor = UIColor.red.cgColor
        
        // https://github.com/kirkbyo/Dropper
        dropper = Dropper(width: dropdown.frame.width - 40, height: 300)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
