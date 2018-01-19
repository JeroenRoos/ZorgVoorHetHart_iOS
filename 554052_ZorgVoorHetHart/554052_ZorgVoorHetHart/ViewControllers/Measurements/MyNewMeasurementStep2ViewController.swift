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
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
        
        // Set the TableView delegates
        tableViewHealthIssues.delegate = self
        tableViewHealthIssues.dataSource = self
        
        // Set the UI for when the user has complaints to hidden
        complaintsHiddenStateChange(withValue: true)
        
        // Get all the health issues
        getHealthIssues()
    }
    
    // Get the amount of rows from the List
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return lstHealthIssues.count
    }
    
    // Initialize the tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Get the current cell
        let customCell = tableView.dequeueReusableCell(withIdentifier: "healthIssueCell", for: indexPath) as! MyHealthIssueTableViewCell
        
        // Initialize the UI for the cell
        customCell.initCheckbox(healthIssue: lstHealthIssues[indexPath.row])
        return customCell
    }
    
    // Get all the Health Issues if needed
    private func getHealthIssues()
    {
        // Check if the health issues instance is not empty, this is needed to make sure there won't be a new network requests if the health issues are already received in Meting home
        if (HealthIssue.healthIssuesInstance.isEmpty)
        {
            SwiftSpinner.show("Bezig met het ophalen van de benodigde data...")
            
            // Get all the healthIssues
            service.getHealthIssues(withSuccess: { (healthIssues: [HealthIssue]) in
                // Save the healthissues and initialize the UI for the checkboxes
                HealthIssue.healthIssuesInstance = healthIssues
                self.lstHealthIssues = healthIssues
                self.InitCheckboxesAndTextWithData()
                SwiftSpinner.hide()
            }, orFailure: { (error: String, title) in
                // Set the UI correctly for either a new measurement of edit of a measurement
                if (self.editingMeasurement)
                {
                    self.title = "Nieuwe meting: stap 2 van 2"
                    self.txtDate.text = "Datum originele meting: " + (self.measurement?.measurementDateTimeFormatted)!
                }
                else
                {
                    self.title = "Nieuwe meting: stap 2 van 2"
                    self.txtDate.text = "Datum: " + (Date().getCurrentWeekdayAndDate())!
                }
                
                // Set the error message and make sure the user can't access the complaints radiobutton
                self.radioNoComplaints_OnClick(self.radioNoComplaints)
                self.radioComplaints.isEnabled = false
                self.txtNoComplaints.textColor = UIColor.red
                self.txtNoComplaints.text = "Er is iets fout gegaan bij het ophalen van de gezondheidsproblemen"
                
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            })
        }
        else
        {
            // If the previous request worked get the health issues and initialize the checkbox UI
            self.lstHealthIssues = HealthIssue.healthIssuesInstance
            InitCheckboxesAndTextWithData()
        }
    }
    
    // Initalize the UI for the checkboxes
    private func InitCheckboxesAndTextWithData()
    {
        // Reload the table view
        DispatchQueue.main.async {
            self.tableViewHealthIssues.reloadData()
        }
        
        // Set the UI correctly
        if (!self.editingMeasurement)
        {
            self.title = "Nieuwe meting: stap 2 van 2"
            self.measurement?.healthIssueIds = []
            self.measurement?.healthIssueOther = ""
            self.txtDate.text = "Datum: " + (Date().getCurrentWeekdayAndDate())!
        }
        else
        {
            // If this is an edit of a measurement set the values from the measurement in the checkboxes and the input view
            self.title = "Meting bewerken: stap 2 van 2"
            self.txtDate.text = "Datum originele meting: " + (self.measurement?.measurementDateTimeFormatted)!
            
            // Make sure the measurement that is being edited actually had health issues
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
    }
    
    // Set the UI for the checkboxes if the user is editing a measurement
    private func setCheckboxesAndTextField()
    {
        // If the user had healthissues, make sure the checkboxes UI is visible
        complaintsHiddenStateChange(withValue: false)
        txtNoComplaints.isHidden = true
        radioComplaints.isChecked = true
        radioNoComplaints.isChecked = false
        tableViewHealthIssues.isHidden = false
        
        // Loop though the all the healthissues and through the selected health issues from the measurement that is being edited
        for i in 0 ..< (self.measurement?.healthIssueIds?.count)!
        {
            for index in 0 ..< lstHealthIssues.count
            {
                // Get the current checkbox
                let indexPath = IndexPath(row: index, section: 0)
                let cell = self.tableViewHealthIssues.cellForRow(at: indexPath) as! MyHealthIssueTableViewCell
                let checkbox = cell.checkboxHealthIssue
                
                // Check if the identifiert (with the ID of the health issue stored in it) equals the ID from the health issues from the measurement that is being edited
                if (checkbox?.accessibilityIdentifier! == measurement?.healthIssueIds![i])
                {
                    // Set the checkbox to checked
                    checkbox?.isChecked = true
                    break
                }
            }
        }
        
        // Check if the extra input wasn't nil or empty and set the text when needed
        if (measurement?.healthIssueOther != nil &&
            measurement?.healthIssueOther != "")
        {
            inputOther.text = measurement?.healthIssueOther!
        }
    }
    
    // Called when the user pressed the "Afronden" button, this method wil check all the user input and determine the validity
    @IBAction func btnNext_OnClick(_ sender: Any)
    {
        SwiftSpinner.show("Bezig met het maken van uw meting...")
        self.btnNext.isEnabled = false
        
        // Remove all the health issues from the measurement, this is needed to correctly put the selected health issues in the measurement while editing a measurement
        measurement?.healthIssueIds?.removeAll()
        for index in 0 ..< lstHealthIssues.count
        {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.tableViewHealthIssues.cellForRow(at: indexPath) as! MyHealthIssueTableViewCell
            let checkbox = cell.checkboxHealthIssue
            
            // Check if the checkbox is checked, if this is the case, add the health issue ID to the measurement
            if (checkbox?.isChecked)!
            {
                print(checkbox?.accessibilityIdentifier ?? "")
                measurement?.healthIssueIds?.append((checkbox?.accessibilityIdentifier!)!)
            }
        }
        
        // Put the other values in the measurement
        measurement?.healthIssueOther? = inputOther.text!
        measurement?.userId = (User.loggedinUser?.userId)!
        
        // Determine which network request to make
        if (!editingMeasurement)
        {
            // Network request to add the new measurement to the database
            measurementService.postNewMeasurement(
                withSuccess: { () in
                    // Set the date of the measurement in the user defaults
                    let key = (User.loggedinUser?.userId)! + "date"
                    self.defaults.set(Date(), forKey: key)
                    
                    self.btnNext.isEnabled = true
                    SwiftSpinner.hide()
                    self.performSegue(withIdentifier: "measurementFinish", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnNext.isEnabled = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andMeasurement: measurement!)
        }
        else
        {
            // Network request to edit an existing measurement in the database
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
    
    // Prepare the data in the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Identify the segue
        if(segue.identifier == "measurementFinish")
        {
            if let viewController = segue.destination as? MyNewMeasurementFinishedViewController
            {
                viewController.editingMeasurement = editingMeasurement
            }
        }
    }
    
    // Called when the radio button for no complaints is clicked
    @IBAction func radioNoComplaints_OnClick(_ sender: Any)
    {
        // Set all the UI needed when a user had complaints to hidden
        complaintsHiddenStateChange(withValue: true)
        txtNoComplaints.isHidden = false

        // Unchecked all the checkboxes
        for index in 0 ..< lstHealthIssues.count
        {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.tableViewHealthIssues.cellForRow(at: indexPath) as! MyHealthIssueTableViewCell
            let checkbox = cell.checkboxHealthIssue
            checkbox?.isChecked = false
        }
        
        // Reset the textfield text
        inputOther.text = ""
    }
    
    // Called when the radio button for complaints is clicked
    @IBAction func radioComplaints_OnClick(_ sender: Any)
    {
        // Set all the UI needed when a user had complaints to visible
        complaintsHiddenStateChange(withValue: false)
        txtNoComplaints.isHidden = true
    }
    
    // Called when the text field did end editing
    @objc func textDidEndEditing(_ textField: UITextField)
    {
        animateViewMoving(up: false, moveValue: 100)
    }
    
    // Called when the texfield did begin editing
    @objc func textDidBeginEditing(_ textField: UITextField)
    {
        animateViewMoving(up: true, moveValue: 100)
    }
    
    // Lift up the input field when the keyboard appears
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
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        txtDate.font = txtDate.font.withSize(12)
        
        txtTitle.text = "Heeft u regelmatig last van gezondheidsklachten?"
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
    
    // Set all the UI hidden or visible
    private func complaintsHiddenStateChange(withValue state: Bool)
    {
        inputOther.isHidden = state
        txtOther.isHidden = state
        tableViewHealthIssues.isHidden = state
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
