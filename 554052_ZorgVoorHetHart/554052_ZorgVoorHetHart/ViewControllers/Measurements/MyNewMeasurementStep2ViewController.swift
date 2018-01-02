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
    
    private var lstCheckboxes : [CheckboxHelper] = []
    private var lstHealthIssues : [HealthIssue] = []
    private let service: HealthIssuesService = HealthIssuesService()
    private let measurementService: MeasurementService = MeasurementService()
    var measurement: Measurement? = nil
    var editingMeasurement: Bool = false
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
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
        
        lstCheckboxes.append(checkComplaint01)
        lstCheckboxes.append(checkComplaint02)
        lstCheckboxes.append(checkComplaint03)
        lstCheckboxes.append(checkComplaint04)
        lstCheckboxes.append(checkComplaint05)
        lstCheckboxes.append(checkComplaint06)
        
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
        getHealthIssues()
    }
    
    private func getHealthIssues()
    {
        service.getHealthIssues(
            withSuccess: { (healthIssues: [HealthIssue]) in
                
                // Sla deze health issues later opnieuw op
                self.lstHealthIssues = healthIssues
                
                for i in 0 ..< self.lstHealthIssues.count - 1
                {
                    self.lstCheckboxes[i].setTitle(self.lstHealthIssues[i].name, for: .normal)
                    self.lstCheckboxes[i].accessibilityIdentifier = self.lstHealthIssues[i].issueId
                }
                
                if (!self.editingMeasurement)
                {
                    self.title = "Nieuwe meting: stap 2 van 2"
                    self.measurement?.healthIssueIds = []
                    self.measurement?.healthIssueOther = ""
                    self.txtDate.text = (Date().getCurrentWeekdayAndDate())
                }
                else
                {
                    self.title = "Meting aanpassen: stap 2 van 2"
                    self.txtDate.text = "Datum originele meting: " + Date().getDateInCorrectFormat(myDate: (self.measurement?.measurementDateTime)!)!
                    
                    if (self.measurement?.healthIssueIds != nil &&
                        !(self.measurement?.healthIssueIds?.isEmpty)! ||
                        self.measurement?.healthIssueOther != "")
                        //(!(self.measurement?.healthIssueIds?.isEmpty)!)
                    {
                        self.setCheckboxesAndTextField()
                    }
                }
        }, orFailure: { (error: String) in
            self.title = "Nieuwe meting: stap 2 van 3"
            for checkbox in self.lstCheckboxes
            {
                checkbox.setTitle("[placeholder]", for: .normal)
                checkbox.setTitleColor(UIColor.black, for: .normal)
            }
        })
    }
    
    private func setCheckboxesAndTextField()
    {
        complaintsHiddenStateChange(state: false)
        radioComplaints.isChecked = true
        radioNoComplaints.isChecked = false
        
        for i in 0 ..< (self.measurement?.healthIssueIds?.count)!
        {
            for checkbox in lstCheckboxes
            {
                print(checkbox.accessibilityIdentifier ?? "")
                if (checkbox.accessibilityIdentifier! == measurement?.healthIssueIds![i])
                {
                    checkbox.isChecked = true
                    break
                }
            }
        }
        
        if (measurement?.healthIssueOther != "")
        {
            inputOther.text = measurement?.healthIssueOther!
        }
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
        // Check if the list with ID's already contains the ID (needed when editing the measurement)
        measurement?.healthIssueIds?.removeAll()
        for checkbox in lstCheckboxes
        {
            if (checkbox.isChecked)
            {
                print(checkbox.accessibilityIdentifier ?? "")
                measurement?.healthIssueIds?.append(checkbox.accessibilityIdentifier!)
                
            }
        }
        
        measurement?.healthIssueOther? = inputOther.text!
        measurement?.userId = (User.loggedinUser?.userId)!
        
        if (!editingMeasurement)
        {
            measurementService.postNewMeasurement(
                withSuccess: { (message: String) in
                self.performSegue(withIdentifier: "measurementFinish", sender: self)
                    print(Date())
                    
                    let key = (User.loggedinUser?.userId)! + "date"
                    self.defaults.set(Date(), forKey: key)
            }, orFailure: { (error: String) in
                
            }, andMeasurement: measurement!)
        }
        else
        {
            measurementService.updateMeasurement(
                withSuccess: { (message: String) in
                    self.performSegue(withIdentifier: "measurementFinish", sender: self)
                    
            }, orFailure: { (error: String) in
                
            }, andMeasurement: measurement!)
        }
    }
    
    @IBAction func radioNoComplaints_OnClick(_ sender: Any)
    {
        complaintsHiddenStateChange(state: true)
        
        for checkbox in lstCheckboxes
        {
            checkbox.isChecked = false
        }
        inputOther.text = ""
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
