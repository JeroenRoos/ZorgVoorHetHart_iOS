//
//  MeasurementHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 20/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftSpinner

class MyMeasurementHomeViewController: UIViewController
{
    @IBOutlet weak var txtSquareMiddle: UILabel!
    @IBOutlet weak var txtUpperBar: UILabel!
    @IBOutlet weak var btnNewMeasurement: UIButton!
    private let service: HealthIssuesService = HealthIssuesService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Meting"
        
        // Fetch all the HealthIssues, they aren't needed in this ViewController, but they are almost 100% needed when the app is used
        fetchHealthIssues()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        // Get the date from the last measurement from the UserDefaults
        let key = (User.loggedinUser?.userId)! + "date"
        let dateLastMeasurement = UserDefaults.standard.object(forKey: key)
        
        // Check if the date isn't nil, if this is the case it is the first measurement of the user and the text will be set
        if (dateLastMeasurement != nil)
        {
            // Check if the date of the last measurement is the same as today
            let sameDay = Calendar.current.isDateInToday(dateLastMeasurement as! Date)
            if (sameDay)
            {
                txtSquareMiddle.text = "U heeft vandaag al een meting gedaan, wilt u er nog een doen?"
            }
            else
            {
                txtSquareMiddle.text = "Vul een nieuwe meting in"
            }
        }
        else
        {
            txtSquareMiddle.text = "Vul uw eerste meting in"
        }
    }
    
    // Fetch all the Health Issues from the database
    private func fetchHealthIssues()
    {
        SwiftSpinner.show("Bezig met inloggen...")
        
        // Try the network request to get all health issues, this result will be a success or failure callback
        service.getHealthIssues(
            withSuccess: { (healthIssues: [HealthIssue]) in
                // Store the health issues for later use
                HealthIssue.healthIssuesInstance = healthIssues
                SwiftSpinner.hide()
        }, orFailure: { (error: String, title: String) in
            SwiftSpinner.hide()
            self.showAlertBox(withMessage: error, andTitle: title)
        })
    }
    
    // Called when the user presses the "Nieuwe Meting" button
    @IBAction func btnNewMeasuremnt_OnClick(_ sender: Any)
    {
        self.performSegue(withIdentifier: "newMeasurement", sender: self)
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        txtSquareMiddle.font = txtSquareMiddle.font.withSize(12)
        btnNewMeasurement.setTitleColor(UIColor.white, for: .normal)
        btnNewMeasurement.backgroundColor = UIColor(rgb: 0xE84A4A)
        btnNewMeasurement.setTitle("Start nieuwe meting", for: .normal)
        
        txtUpperBar.text = "Goedenmiddag " + (User.loggedinUser?.firstName)!
        txtUpperBar.font = txtUpperBar.font.withSize(14)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
