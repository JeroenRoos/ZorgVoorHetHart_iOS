//
//  MyNewMeasurementStep2ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 27/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyNewMeasurementStep2ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var inputOther: UITextField!
    @IBOutlet weak var txtOther: UILabel!
    @IBOutlet weak var checkComplaint05: CheckboxHelper!
    @IBOutlet weak var checkComplaint06: CheckboxHelper!
    @IBOutlet weak var checkComplaint04: CheckboxHelper!
    @IBOutlet weak var checkComplaint03: CheckboxHelper!
    @IBOutlet weak var checkComplaint02: CheckboxHelper!
    @IBOutlet weak var checkComplaint01: CheckboxHelper!
    @IBOutlet weak var radioComplaints: RadioButtonHelper!
    @IBOutlet weak var radioNoComplaints: RadioButtonHelper!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Nieuwe meting: stap 2 van 3"
        self.hideKeyboardWhenTappedAround()
        
        txtDate.text = (Date().getCurrentWeekdayAndDate())
        txtDate.font = txtDate.font.withSize(12)
        
        txtTitle.text = "2. Gezondheidsklachten"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        radioComplaints.setTitle("Ja, namelijk", for: .normal)
        radioComplaints.setTitleColor(UIColor.black, for: .normal)
        radioComplaints.isChecked = false
        radioComplaints?.alternateButton = [radioNoComplaints!]
        radioComplaints.layer.borderWidth = 0
        
        radioNoComplaints.setTitle("Geen", for: .normal)
        radioNoComplaints.setTitleColor(UIColor.black, for: .normal)
        radioNoComplaints.isChecked = true
        radioNoComplaints?.alternateButton = [radioComplaints!]
        radioNoComplaints.layer.borderWidth = 0
        
        var lstCheckboxes : [CheckboxHelper] = []
        lstCheckboxes.append(checkComplaint01)
        lstCheckboxes.append(checkComplaint02)
        lstCheckboxes.append(checkComplaint03)
        lstCheckboxes.append(checkComplaint04)
        lstCheckboxes.append(checkComplaint05)
        lstCheckboxes.append(checkComplaint06)
        
        for checkbox in lstCheckboxes
        {
            checkbox.setTitle("[placeholder]", for: .normal)
            checkbox.setTitleColor(UIColor.black, for: .normal)
        }
        
        txtOther.text = "Anders, namelijk:"
        txtOther.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputOther.placeholder = "0"
        inputOther.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputOther.layer.borderWidth = 0
        self.inputOther.delegate = self
        
        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnBack.setTitle("Terug", for: .normal)
        btnBack.setTitleColor(UIColor.white, for: .normal)
        btnBack.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        
        complaintsHiddenStateChange(state: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnBack_OnClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        
        self.performSegue(withIdentifier: "next", sender: self)
    }
    
    @IBAction func radioNoComplaints_OnClick(_ sender: Any)
    {
        complaintsHiddenStateChange(state: true)
    }
    
    @IBAction func radioComplaints_OnClick(_ sender: Any)
    {
        complaintsHiddenStateChange(state: false)
    }
    
    private func complaintsHiddenStateChange(state: Bool)
    {
        inputOther.isHidden = state
        txtOther.isHidden = state
        checkComplaint05.isHidden = state
        checkComplaint06.isHidden = state
        checkComplaint04.isHidden = state
        checkComplaint03.isHidden = state
        checkComplaint02.isHidden = state
        checkComplaint01.isHidden = state
    }
}
