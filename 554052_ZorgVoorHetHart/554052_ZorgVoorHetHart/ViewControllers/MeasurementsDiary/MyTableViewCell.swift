//
//  MyTableViewCell.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 01/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell
{
    @IBOutlet weak var txtBloeddruk: UILabel!
    @IBOutlet weak var txtOnderdruk: UILabel!
    @IBOutlet weak var txtBovendruk: UILabel!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Initialize the User Interface for this cell
    func initUserInterface(measurement: Measurement)
    {
        txtBloeddruk.text = measurement.measurementDateTimeFormatted
        txtBloeddruk.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        txtDate.text = measurement.measurementDateTimeFormatted
        txtDate.isHidden = true
        txtOnderdruk.text = "Onderdruk: " + String(measurement.bloodPressureLower)
        txtBovendruk.text = "Bovendruk: " + String(measurement.bloodPressureUpper)
        txtStatus.font = txtStatus.font.withSize(12)
        
        // Set the feedback for the measurement
        setMeasurementFeedback(withResult: measurement.result, andFeedback: measurement.feedback)

    }
    
    // Set the feedback of the measurement based on the result integer
    private func setMeasurementFeedback(withResult result: Int, andFeedback feedback: String)
    {
        // Set the colors of the cell based upon the feedback
        if (result == 0)
        {
            txtStatus.textColor = UIColor(rgb: 0x35C264)
            self.backgroundColor = UIColor(rgb: 0xE7F6EC)
        }
        else if (result == 1)
        {
            txtStatus.textColor = UIColor(rgb: 0xB27300)
            self.backgroundColor = UIColor(rgb: 0xFFE4B2)
        }
        else
        {
            txtStatus.textColor = UIColor(rgb: 0xEB6666)
            self.backgroundColor = UIColor(rgb: 0xF8E2E3)
        }
        
        txtStatus.text = feedback
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
