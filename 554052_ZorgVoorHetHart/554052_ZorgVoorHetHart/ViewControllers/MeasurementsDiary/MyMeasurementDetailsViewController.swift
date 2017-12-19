//
//  MyMeasurementDetailsViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 01/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyMeasurementDetailsViewController: UIViewController
{
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnBack: UIButton!
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
        
        btnBack.setTitle("Terug", for: .normal)
        btnBack.setTitleColor(UIColor.white, for: .normal)
        btnBack.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnEdit.setTitle("Bewerken", for: .normal)
        btnEdit.setTitleColor(UIColor.white, for: .normal)
        btnEdit.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        txtOnderdruk.text = "Onderdruk: " + String((clickedMeasurement?.bloodPressureLower)!)
        txtOnderdruk.font = txtOnderdruk.font.withSize(12)
        
        txtBovendruk.text = "Bovendruk: " + String((clickedMeasurement?.bloodPressureUpper)!)
        txtBovendruk.font = txtBovendruk.font.withSize(12)
        
        txtBloedrukTitle.text = "Bloeddruk"
        txtBloedrukTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        txtKlachtenTitle.text = "Gezondheidsklachten"
        txtKlachtenTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        txtKlachten.text = ""
        txtKlachten.font = txtKlachten.font.withSize(12)
        
        let date = clickedMeasurement?.measurementDateTime
        txtDatum.text = ""
        txtDatum.font = txtDatum.font.withSize(12)
        
        // Berekening over hoe goed de bloeddruk is
        txtStatus.text = "Uw bloeddruk was prima!"
        txtStatus.font = txtStatus.font.withSize(12)
        txtStatus.textColor = UIColor.green
        
        if (!(clickedMeasurement?.healthIssueIds?.isEmpty)!)
        {
            getHealthIssues()
        }
        else
        {
            self.txtKlachten.isHidden = true
            self.txtKlachtenTitle.isHidden = true
        }
    }
    
    private func getHealthIssues()
    {
        service.getHealthIssues(
            withSuccess: { (healthIssues: [HealthIssue]) in
                self.lstHealthIssues = healthIssues
                
                for id in (self.clickedMeasurement?.healthIssueIds)!
                {
                    let issue = self.lstHealthIssues.filterHealthIssueForId(id: id)
                    self.txtKlachten.text?.append(issue.name + "\n")
                }
                
        }, orFailure: { (error: String) in
            self.txtKlachtenTitle.text = "Er is fout gegaan bij het ophalen van de gezondheidsklachten"
            self.txtKlachten.isHidden = true
        })
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
