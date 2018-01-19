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
    
        // Initialize the User Interface for this ViewController
        initUserInterface()
        
        // Fetch all the consultants from the Database
        fetchConsultants()
    }
    
    // Perform the network request to get all the consultants, the result will either be a failure or success callback
    private func fetchConsultants()
    {
        // Show the spinner to make sure the user knows the app didn't freeze
        SwiftSpinner.show("Bezig met het ophalen van de benodigde data...")
        
        // Perform the network request
        service.getConsultans(
            withSuccess: { (consultants: [Consultant]) in
                // Make the dropdown with consultants visible and make sure the dropdown shows the names of the Consultants
                self.dropdown.isHidden = false
                self.lstConsultants = consultants
                self.getConsultantsNames()
                SwiftSpinner.hide()
        }, orFailure: { (error: String, title: String) in
            // Show the error messages, hide the spinner and show an alert box letting the user know the request failed
            self.errorConsultant.isHidden = false
            self.errorConsultant.text = "Er is iets fout gegaan bij het ophalen van de consulenten"
            self.dropper?.layer.borderWidth = 1
            SwiftSpinner.hide()
            self.showAlertBox(withMessage: error, andTitle: title)
        })
    }
    
    // Put the first- and lastname of each consultant together to show in the dropdown
    private func getConsultantsNames()
    {
        for index in 0 ..< lstConsultants.count
        {
            let name = lstConsultants[index].firstName
                + " " + lstConsultants[index].lastName
            self.lstConsultantsNames.append(name)
        }
    }
    
    // Set the dropdown (Dropper CocaoPod)
    @IBAction func DropdownAction(_ sender: Any)
    {
        dropper?.delegate = self
        dropper?.cornerRadius = 5
        dropper?.items = lstConsultantsNames
        dropper?.maxHeight = 400
        dropper?.showWithAnimation(0.15, options: Dropper.Alignment.center, button: dropdown)
    }
    
    // When the user selects an consultant from the dropdown
    func DropperSelectedRow(_ path: IndexPath, contents: String, tag: Int)
    {
        // Get the name of the pressed consultant from the dropdown
        let consultant = lstConsultantsNames[path.row]
        
        // Set the title of the dropdown to the selected name
        dropdown.setTitle("  " + consultant, for: .normal)
        
        // Loop through the consultants and compare the names with the selected name, this is needed because I need the ID of the consultant for the User
        for index in 0 ..< lstConsultants.count
        {
            // Get the name of the consultant from the loop
            let name = lstConsultants[index].firstName
                + " " + lstConsultants[index].lastName
            
            // Compare the selected name with the name of the consultant, if the names are equal, get the consultant ID and put it in User
            if (consultant == name)
            {
                user?.consultantId = lstConsultants[index].consultantId
                errorConsultant.isHidden = true
                break
            }
        }
    }

    // Called when the user pressed the "Afronden" button, this method wil check all the user input and determine the validity
    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
        // Check if the consultant ID isn't empty
        if (!(user?.consultantId.isEmpty)!)
        {
            // Show the spinner and disable the Finish button to make sure the user can't press twice
            SwiftSpinner.show("Bezig met registreren van uw account...")
            self.btnFinish.isEnabled = false
            
            // Perform the register request
            userService.register(withSuccess: { () in
                self.btnFinish.isEnabled = true
                SwiftSpinner.hide()
                
                // Perform the segue to the next ViewController
                self.performSegue(withIdentifier: "registerFinish", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnFinish.isEnabled = true
                SwiftSpinner.hide()
                
                // Show the alert that something went wrong
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andUser: user!)
        }
        else
        {
            // If the user didn't choose an consultant show the error message
            errorConsultant.isHidden = false
            self.errorConsultant.text = "Uw consultent kan niet leeg zijn"
        }
    }
    
    // Perpare the next ViewController with the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Identify the segue
        if(segue.identifier == "registerFinish")
        {
            // Pass the user to the next ViewController
            if let viewController = segue.destination as? MyRegisterFinishedViewController
            {
                viewController.user = user
            }
        }
    }
    
    // Initialize the User Interface for this ViewController
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
