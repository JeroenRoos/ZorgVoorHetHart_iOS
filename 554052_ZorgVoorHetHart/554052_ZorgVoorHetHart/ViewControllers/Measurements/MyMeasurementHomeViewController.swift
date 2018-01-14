//
//  MeasurementHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 20/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import UserNotifications

class MyMeasurementHomeViewController: UIViewController
{
    @IBOutlet weak var txtSquareMiddle: UILabel!
    @IBOutlet weak var txtUpperBar: UILabel!
    @IBOutlet weak var btnNewMeasurement: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Meting"
        
        txtSquareMiddle.font = txtSquareMiddle.font.withSize(12)
        btnNewMeasurement.setTitleColor(UIColor.white, for: .normal)
        btnNewMeasurement.backgroundColor = UIColor(rgb: 0xE84A4A)
        btnNewMeasurement.setTitle("Start nieuwe meting", for: .normal)

        txtUpperBar.text = "Goedenmiddag " + (User.loggedinUser?.firstName)!
        txtUpperBar.font = txtUpperBar.font.withSize(14)
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
                btnNewMeasurement.isHidden = true
                txtSquareMiddle.text = "U heeft vandaag al een meting gedaan. U kunt uw meting bekijken in uw dagboek"
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
}
