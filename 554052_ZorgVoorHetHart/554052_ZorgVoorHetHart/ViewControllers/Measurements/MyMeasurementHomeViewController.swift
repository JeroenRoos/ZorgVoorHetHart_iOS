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
        
        fetchHealthIssues()
        initUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        // This needs to be called not only on viewDidLoad but on viewDidAppear
        let key = (User.loggedinUser?.userId)! + "date"
        let dateLastMeasurement = UserDefaults.standard.object(forKey: key)
        if (dateLastMeasurement != nil)
        {
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
     
    private func fetchHealthIssues()
    {
        SwiftSpinner.show("Bezig met inloggen...")
        service.getHealthIssues(
            withSuccess: { (healthIssues: [HealthIssue]) in
                HealthIssue.healthIssuesInstance = healthIssues
                SwiftSpinner.hide()
        }, orFailure: { (error: String, title: String) in
            SwiftSpinner.hide()
            self.showAlertBox(withMessage: error, andTitle: title)
        })
    }
    
    @IBAction func btnNewMeasuremnt_OnClick(_ sender: Any)
    {
        self.performSegue(withIdentifier: "newMeasurement", sender: self)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bntClick(_ sender: Any)
    {
            self.performSegue(withIdentifier: "next", sender: self)
    }
    
    @IBAction func btnInformation_OnClick(_ sender: Any)
    {
        
        self.performSegue(withIdentifier: "information", sender: self)
    }
    
    private func initUserInterface()
    {
        txtSquareMiddle.font = txtSquareMiddle.font.withSize(12)
        btnNewMeasurement.setTitleColor(UIColor.white, for: .normal)
        btnNewMeasurement.backgroundColor = UIColor(rgb: 0xE84A4A)
        btnNewMeasurement.setTitle("Start nieuwe meting", for: .normal)
        
        txtUpperBar.text = "Goedenmiddag " + (User.loggedinUser?.firstName)!
        txtUpperBar.font = txtUpperBar.font.withSize(14)
    }
}
