//
//  MyNewMeasurementStep2ViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 27/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyNewMeasurementStep2ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var inputOther: UITextField!
    @IBOutlet weak var txtOther: UILabel!
    //@IBOutlet weak var checkComplaint05: CheckboxHelper!
    //@IBOutlet weak var checkComplaint06: CheckboxHelper!
    //@IBOutlet weak var checkComplaint04: CheckboxHelper!
    //@IBOutlet weak var checkComplaint03: CheckboxHelper!
    //@IBOutlet weak var checkComplaint02: CheckboxHelper!
    //@IBOutlet weak var checkComplaint01: CheckboxHelper!
    @IBOutlet weak var radioComplaints: RadioButtonHelper!
    @IBOutlet weak var radioNoComplaints: RadioButtonHelper!
    @IBOutlet weak var tableViewHealthIssues: UITableView!
    
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
        
        txtOther.text = "Anders, namelijk:"
        txtOther.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputOther.placeholder = "Vul hier uw andere gezondsheidsklachten in, als u deze heeft"
        inputOther.placeholderTextColor = UIColor.gray
        inputOther.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputOther.layer.borderWidth = 0
        self.inputOther.delegate = self
        
        btnNext.setTitle("Volgende", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0xE84A4A)
        
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
                    self.txtDate.text = (Date().getCurrentWeekdayAndDate())
                }
                else
                {
                    self.title = "Meting aanpassen: stap 2 van 2"
                    self.txtDate.text = "Datum originele meting: " + (self.measurement?.measurementDateTimeFormatted)!
                    
                    if (self.measurement?.healthIssueIds != nil &&
                        !(self.measurement?.healthIssueIds?.isEmpty)! ||
                        self.measurement?.healthIssueOther != "")
                    {
                        DispatchQueue.main.async {
                            self.setCheckboxesAndTextField()
                        }
                    }
                }
                
        }, orFailure: { (error: String, title) in
            self.title = "Nieuwe meting: stap 2 van 3"
            self.showAlertBox(withMessage: error, andTitle: title)
        })
    }
    
    private func setCheckboxesAndTextField()
    {
        complaintsHiddenStateChange(state: false)
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
            /*for checkbox in lstCheckboxes
            {
                print(checkbox.accessibilityIdentifier ?? "")
                if (checkbox.accessibilityIdentifier! == measurement?.healthIssueIds![i])
                {
                    checkbox.isChecked = true
                    break
                }
            }*/
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
    
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
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
            /*for checkbox in lstCheckboxes
            {
                if (checkbox.isChecked)
                {
                    print(checkbox.accessibilityIdentifier ?? "")
                    measurement?.healthIssueIds?.append(checkbox.accessibilityIdentifier!)
                }
            }*/
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
                    self.performSegue(withIdentifier: "measurementFinish", sender: self)
                    print(Date())
            }, orFailure: { (error: String, title: String) in
                self.btnNext.isEnabled = true
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andMeasurement: measurement!)
        }
        else
        {
            measurementService.updateMeasurement(
                withSuccess: { () in
                    self.btnNext.isEnabled = true
                    self.performSegue(withIdentifier: "measurementFinish", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnNext.isEnabled = true
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andMeasurement: measurement!)
        }
    }
    
    @IBAction func radioNoComplaints_OnClick(_ sender: Any)
    {
        complaintsHiddenStateChange(state: true)
        
        /*for checkbox in lstCheckboxes
        {
            checkbox.isChecked = false
        }*/
        for index in 0 ..< lstHealthIssues.count
        {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.tableViewHealthIssues.cellForRow(at: indexPath) as! MyHealthIssueTableViewCell
            let checkbox = cell.checkboxHealthIssue
            checkbox?.isChecked = false
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
        tableViewHealthIssues.isHidden = state
    }
}
