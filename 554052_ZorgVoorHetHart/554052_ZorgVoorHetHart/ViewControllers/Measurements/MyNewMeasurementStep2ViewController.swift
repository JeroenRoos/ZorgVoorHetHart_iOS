//
//  MyNewMeasurementStep2ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 27/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import SwiftSpinner

class MyNewMeasurementStep2ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var inputOther: UITextField!
    @IBOutlet weak var txtOther: UILabel!
    @IBOutlet weak var radioComplaints: RadioButtonHelper!
    @IBOutlet weak var radioNoComplaints: RadioButtonHelper!
    @IBOutlet weak var tableViewHealthIssues: UITableView!
    @IBOutlet weak var txtNoComplaints: UILabel!
    
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
        
        initUserInterface()
        
        tableViewHealthIssues.delegate = self
        tableViewHealthIssues.dataSource = self
        complaintsHiddenStateChange(state: true)
        getHealthIssues()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return lstHealthIssues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "healthIssueCell", for: indexPath) as! MyHealthIssueTableViewCell
        customCell.initCheckbox(healthIssue: lstHealthIssues[indexPath.row])
        return customCell
    }
    
    private func getHealthIssues()
    {
        SwiftSpinner.show("Bezig met het ophalen van de benodigde data...")
        
        service.getHealthIssues(
            withSuccess: { (healthIssues: [HealthIssue]) in
                
                // Sla deze health issues later opnieuw op
                self.lstHealthIssues = healthIssues
                DispatchQueue.main.async {
                    self.tableViewHealthIssues.reloadData()
                }
                
                if (!self.editingMeasurement)
                {
                    self.title = "Nieuwe meting: stap 2 van 2"
                    self.measurement?.healthIssueIds = []
                    self.measurement?.healthIssueOther = ""
                    self.txtDate.text = "Datum: " + (Date().getCurrentWeekdayAndDate())!
                }
                else
                {
                    self.title = "Meting bewerken: stap 2 van 2"
                    self.txtDate.text = "Datum originele meting: " + (self.measurement?.measurementDateTimeFormatted)!
                    
                    if (self.measurement?.healthIssueIds != nil &&
                        !(self.measurement?.healthIssueIds?.isEmpty)! ||
                        (self.measurement?.healthIssueOther != nil &&
                        self.measurement?.healthIssueOther != ""))
                    {
                        DispatchQueue.main.async {
                            self.setCheckboxesAndTextField()
                        }
                    }
                }
                SwiftSpinner.hide()
        }, orFailure: { (error: String, title) in
            self.title = "Nieuwe meting: stap 2 van 3"
            SwiftSpinner.hide()
            self.showAlertBox(withMessage: error, andTitle: title)
        })
    }
    
    private func setCheckboxesAndTextField()
    {
        complaintsHiddenStateChange(state: false)
        txtNoComplaints.isHidden = true
        radioComplaints.isChecked = true
        radioNoComplaints.isChecked = false
        tableViewHealthIssues.isHidden = false
        
        for i in 0 ..< (self.measurement?.healthIssueIds?.count)!
        {
            for index in 0 ..< lstHealthIssues.count
            {
                let indexPath = IndexPath(row: index, section: 0)
                let cell = self.tableViewHealthIssues.cellForRow(at: indexPath) as! MyHealthIssueTableViewCell
                let checkbox = cell.checkboxHealthIssue
                
                if (checkbox?.accessibilityIdentifier! == measurement?.healthIssueIds![i])
                {
                    checkbox?.isChecked = true
                    break
                }
            }
        }
        
        if (//measurement?.healthIssueOther != nil &&
            measurement?.healthIssueOther != "")
        {
            inputOther.text = measurement?.healthIssueOther!
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        SwiftSpinner.show("Bezig met het maken van uw meting...")
        // Check if the list with ID's already contains the ID (needed when editing the measurement)
        measurement?.healthIssueIds?.removeAll()
        for index in 0 ..< lstHealthIssues.count
        {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.tableViewHealthIssues.cellForRow(at: indexPath) as! MyHealthIssueTableViewCell
            let checkbox = cell.checkboxHealthIssue
            
            if (checkbox?.isChecked)!
            {
                print(checkbox?.accessibilityIdentifier ?? "")
                measurement?.healthIssueIds?.append((checkbox?.accessibilityIdentifier!)!)
            }
        }
        
        measurement?.healthIssueOther? = inputOther.text!
        measurement?.userId = (User.loggedinUser?.userId)!
        
        self.btnNext.isEnabled = false
        if (!editingMeasurement)
        {
            measurementService.postNewMeasurement(
                withSuccess: { () in
                    let key = (User.loggedinUser?.userId)! + "date"
                    self.defaults.set(Date(), forKey: key)
                    self.btnNext.isEnabled = true
                    SwiftSpinner.hide()
                    self.performSegue(withIdentifier: "measurementFinish", sender: self)
                    print(Date())
            }, orFailure: { (error: String, title: String) in
                self.btnNext.isEnabled = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andMeasurement: measurement!)
        }
        else
        {
            measurementService.updateMeasurement(
                withSuccess: { () in
                    self.btnNext.isEnabled = true
                    SwiftSpinner.hide()
                    self.performSegue(withIdentifier: "measurementFinish", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnNext.isEnabled = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andMeasurement: measurement!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass measurement to next ViewController
        if(segue.identifier == "measurementFinish")
        {
            if let viewController = segue.destination as? MyNewMeasurementFinishedViewController
            {
                viewController.editingMeasurement = editingMeasurement
            }
        }
    }
    
    @IBAction func radioNoComplaints_OnClick(_ sender: Any)
    {
        complaintsHiddenStateChange(state: true)
        txtNoComplaints.isHidden = false

        for index in 0 ..< lstHealthIssues.count
        {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.tableViewHealthIssues.cellForRow(at: indexPath) as! MyHealthIssueTableViewCell
            let checkbox = cell.checkboxHealthIssue
            checkbox?.isChecked = false
        }
        
        inputOther.text = ""
    }
    
    @objc func textDidEndEditing(_ textField: UITextField)
    {
        animateViewMoving(up: false, moveValue: 100)
    }
    
    @objc func textDidBeginEditing(_ textField: UITextField)
    {
        animateViewMoving(up: true, moveValue: 100)
    }
    
    // Lifting the view up
    func animateViewMoving (up:Bool, moveValue :CGFloat)
    {
        let movementDistance:CGFloat = -130
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    @IBAction func radioComplaints_OnClick(_ sender: Any)
    {
        complaintsHiddenStateChange(state: false)
        txtNoComplaints.isHidden = true
    }
    
    private func initUserInterface()
    {
        txtDate.font = txtDate.font.withSize(12)
        
        txtTitle.text = "Heeft u regelmatig last van een of meer van de volgende gezondheidsklachten?"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
        
        radioComplaints.setTitle("Ja, namelijk", for: .normal)
        radioComplaints.setTitleColor(UIColor.black, for: .normal)
        radioComplaints.isChecked = false
        radioComplaints?.alternateButton = [radioNoComplaints!]
        radioComplaints.layer.borderWidth = 0
        
        txtNoComplaints.text = "U heeft geen bijzondere klachten"
        txtNoComplaints.font = txtNoComplaints.font.withSize(12)
        
        radioNoComplaints.setTitle("Nee", for: .normal)
        radioNoComplaints.setTitleColor(UIColor.black, for: .normal)
        radioNoComplaints.isChecked = true
        radioNoComplaints?.alternateButton = [radioComplaints!]
        radioNoComplaints.layer.borderWidth = 0
        
        txtOther.text = "Anders, namelijk:"
        txtOther.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputOther.placeholder = "Vul hier uw andere gezondsheidsklachten in, als u deze heeft"
        inputOther.placeholderTextColor = UIColor.gray
        inputOther.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputOther.layer.borderWidth = 0
        inputOther.addTarget(self, action: #selector(textDidEndEditing(_:)), for: .editingDidEnd)
        inputOther.addTarget(self, action: #selector(textDidBeginEditing(_:)), for: .editingDidBegin)
        self.inputOther.delegate = self
        
        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0xE84A4A)
    }
    
    private func complaintsHiddenStateChange(state: Bool)
    {
        inputOther.isHidden = state
        txtOther.isHidden = state
        tableViewHealthIssues.isHidden = state
    }
}
