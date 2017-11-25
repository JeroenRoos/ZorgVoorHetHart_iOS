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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Registreren stap 1 van 2"
        
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
        
        self.performSegue(withIdentifier: "registerNext", sender: self)
    }
    
    override func awakeFromNib()
    {
        self.view.layoutIfNeeded()
        radioButtonWoman.isChecked = false
        radioButtonMan.isChecked = true
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
