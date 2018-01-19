//
//  MyMeasurementDetailsViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 01/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import SwiftSpinner

class MyMeasurementDetailsViewController: UIViewController
{
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var txtOnderdruk: UILabel!
    @IBOutlet weak var txtKlachten: UILabel!
    @IBOutlet weak var txtKlachtenTitle: UILabel!
    @IBOutlet weak var txtDatum: UILabel!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtBovendruk: UILabel!
    @IBOutlet weak var txtBloedrukTitle: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    var clickedMeasurement: Measurement? = nil
    private var lstHealthIssues : [HealthIssue] = []
    private let service: HealthIssuesService = HealthIssuesService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
        
        // Set the feedback of this measurement based upon the result integer
        setMeasurementFeedback(withResult: (clickedMeasurement?.result)!, andFeedback: (clickedMeasurement?.feedback)!)
        
        // If the measurements contains health issues, get the health issues
        if ((clickedMeasurement?.healthIssueIds != nil &&
            !(clickedMeasurement?.healthIssueIds?.isEmpty)!) ||
            (clickedMeasurement?.healthIssueOther != nil &&
            clickedMeasurement?.healthIssueOther != ""))
        {
            getHealthIssues()
        }
        else
        {
            self.txtKlachten.text = "U had geen andere gezondheidsklachten."
        }
    }
    
    // Set the feedback of the measurement based on the result integer
    private func setMeasurementFeedback(withResult result: Int, andFeedback feedback: String)
    {
        // Set the colors of the cell based upon the feedback
        if (result == 0)
        {
            txtStatus.textColor = UIColor(rgb: 0x35C264)
            imgBackground.backgroundColor = UIColor(rgb: 0xE7F6EC)
        }
        else if (result == 1)
        {
            txtStatus.textColor = UIColor(rgb: 0xB27300)
            imgBackground.backgroundColor = UIColor(rgb: 0xFFE4B2)
        }
        else
        {
            txtStatus.textColor = UIColor(rgb: 0xEB6666)
            imgBackground.backgroundColor = UIColor(rgb: 0xF8E2E3)
        }
        
        txtStatus.text = feedback
    }
    
    // Get all the Health Issues if needed
    private func getHealthIssues()
    {
        // Check if the health issues instance is not empty, this is needed to make sure there won't be a new network requests if the health issues are already received in Meting home
        if (HealthIssue.healthIssuesInstance.isEmpty)
        {
            SwiftSpinner.show("Bezig met het ophalen van de benodigde data...")
            
            // Network request to get all the health issues
            service.getHealthIssues(withSuccess: { (healthIssues: [HealthIssue]) in
                // Save the healthissues and initialize the UI for the health issues
                HealthIssue.healthIssuesInstance = healthIssues
                self.lstHealthIssues = healthIssues
                self.initHealthIssuesWithData()
                SwiftSpinner.hide()
            }, orFailure: { (error: String, title: String) in
                self.txtKlachtenTitle.text = "Er is fout gegaan bij het ophalen van de gezondheidsklachten"
                self.txtKlachten.isHidden = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            })
        }
        else
        {
            // If the previous request worked get the health issues and initialize the health issues UI
            self.lstHealthIssues = HealthIssue.healthIssuesInstance
            self.initHealthIssuesWithData()
        }
    }
    
    // Initialize the UI for the health issues after the data is received
    private func initHealthIssuesWithData()
    {
        // Set the name of each health issue in the label
        for id in (self.clickedMeasurement?.healthIssueIds)!
        {
            let issue = self.lstHealthIssues.filterHealthIssueForId(id: id)
            self.txtKlachten.text?.append(issue.name + "\n")
        }
        
        // Set the other health issues from the input field if there are any
        if (self.clickedMeasurement?.healthIssueOther != nil && self.clickedMeasurement?.healthIssueOther != "")
        {
            // Set the other health issue text based on the other health issues
            if (self.clickedMeasurement?.healthIssueIds?.isEmpty)!
            {
                self.txtKlachten.text?.append((self.clickedMeasurement?.healthIssueOther)!)
            }
            else
            {
                self.txtKlachten.text?.append("\n\nOverige klachten: \n" + (self.clickedMeasurement?.healthIssueOther)!)
            }
        }
    }
    
    // Called when the user presses the "Aanpassen" button
    @IBAction func btnEdit_OnClick(_ sender: Any)
    {
        self.performSegue(withIdentifier: "editMeasurement", sender: self)
    }
    
    // Prepare the data in the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Identify the segue
        if(segue.identifier == "editMeasurement")
        {
            if let viewController = segue.destination as? MyNewMeasurementStep1ViewController
            {
                viewController.measurement = clickedMeasurement
            }
        }
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        btnEdit.setTitle("Bewerken", for: .normal)
        btnEdit.setTitleColor(UIColor.white, for: .normal)
        btnEdit.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        txtOnderdruk.text = "Onderdruk: " + String((clickedMeasurement?.bloodPressureLower)!)
        txtOnderdruk.font = txtOnderdruk.font.withSize(12)
        
        txtBovendruk.text = "Bovendruk: " + String((clickedMeasurement?.bloodPressureUpper)!)
        txtBovendruk.font = txtBovendruk.font.withSize(12)
        
        txtBloedrukTitle.text = clickedMeasurement?.measurementDateTimeFormatted
        txtBloedrukTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        txtKlachtenTitle.text = "Gezondheidsklachten"
        txtKlachtenTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        txtKlachten.text = ""
        txtKlachten.font = txtKlachten.font.withSize(12)
        
        let date = clickedMeasurement?.measurementDateTimeFormatted
        txtDatum.text = date
        txtDatum.font = txtDatum.font.withSize(12)
        txtDatum.isHidden = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
