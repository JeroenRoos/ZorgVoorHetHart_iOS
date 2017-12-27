//
//  MyRegisterStep3ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 19/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Dropper

class MyRegisterStep3ViewController: UIViewController, UITextFieldDelegate, DropperDelegate
{
    @IBOutlet weak var errorConsultant: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    
    @IBOutlet weak var dropdown: UIButton!
    private let decoder = JSONDecoder()
    //private var user: User = User()
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
        
        // https://github.com/kirkbyo/Dropper
        dropper = Dropper(width: dropdown.frame.width - 40, height: 300)
        
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
            self.errorConsultant.isHidden = false
            self.errorConsultant.text = "Er is iets fout gegaan bij het ophalen van de consulenten"
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
            }
        }
    }

    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
        if (!(user?.consultantId.isEmpty)!)
        {
            userService.register(withSuccess: { (message: String) in
                self.performSegue(withIdentifier: "registerFinish", sender: self)
            }, orFailure: { (error: String) in
                
            }, andUser: user!)
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
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
