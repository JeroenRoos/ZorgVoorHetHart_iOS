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
    //@IBOutlet weak var btnBack: UIButton!
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
        
        initUserInterface()
        
        setMeasurementFeedback(result: (clickedMeasurement?.result)!, feedback: (clickedMeasurement?.feedback)!)
        
        if ((clickedMeasurement?.healthIssueIds != nil &&
            !(clickedMeasurement?.healthIssueIds?.isEmpty)!) ||
            (clickedMeasurement?.healthIssueOther != nil &&
            clickedMeasurement?.healthIssueOther != ""))
        {
            getHealthIssues()
        }
        else
        {
            //self.txtKlachten.isHidden = true
            //self.txtKlachtenTitle.isHidden = false
            self.txtKlachten.text = "U had geen andere gezondheidsklachten."
        }
    }
    
    // Red background color = 0xF8E2E3
    // Red text color       = 0xEB6666
    private func setMeasurementFeedback(result: Int, feedback: String)
    {
        if (result == 0)
        {
            txtStatus.text = feedback
            txtStatus.textColor = UIColor(rgb: 0x35C264)
            imgBackground.backgroundColor = UIColor(rgb: 0xE7F6EC)
        }
        else if (result == 1)
        {
            txtStatus.text = feedback
            txtStatus.textColor = UIColor(rgb: 0xB27300)
            imgBackground.backgroundColor = UIColor(rgb: 0xFFE4B2)
        }
        else
        {
            txtStatus.text = feedback
            txtStatus.textColor = UIColor(rgb: 0xEB6666)
            imgBackground.backgroundColor = UIColor(rgb: 0xF8E2E3)
        }
    }
    
    private func getHealthIssues()
    {
        if (HealthIssue.healthIssuesInstance.isEmpty)
        {
            SwiftSpinner.show("Bezig met het ophalen van de benodigde data...")
            service.getHealthIssues(
                withSuccess: { (healthIssues: [HealthIssue]) in
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
            self.lstHealthIssues = HealthIssue.healthIssuesInstance
            initHealthIssuesWithData()
        }
    }
    
    private func initHealthIssuesWithData()
    {
        for id in (self.clickedMeasurement?.healthIssueIds)!
        {
            let issue = self.lstHealthIssues.filterHealthIssueForId(id: id)
            self.txtKlachten.text?.append(issue.name + "\n")
        }
        
        if (self.clickedMeasurement?.healthIssueOther != nil && self.clickedMeasurement?.healthIssueOther != "")
        {
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
    
    @IBAction func btnEdit_OnClick(_ sender: Any)
    {
        self.performSegue(withIdentifier: "editMeasurement", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Pass measurement to next ViewController
        if(segue.identifier == "editMeasurement")
        {
            if let viewController = segue.destination as? MyNewMeasurementStep1ViewController
            {
                viewController.measurement = clickedMeasurement
            }
        }
    }
    
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
        
        // di, 31 okt 2017
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
