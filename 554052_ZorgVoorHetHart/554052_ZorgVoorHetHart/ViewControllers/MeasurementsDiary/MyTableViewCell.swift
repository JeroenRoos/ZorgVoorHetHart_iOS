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
    
    func initUserInterface(measurement: Measurement)
    {
        txtBloeddruk.text = measurement.measurementDateTimeFormatted
        //"Bloeddruk"
        txtBloeddruk.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        txtDate.text = measurement.measurementDateTimeFormatted
            //Date().getDateInCorrectFormat(myDate: measurement.measurementDateTime)
        txtDate.isHidden = true
        txtOnderdruk.text = "Onderdruk: " + String(measurement.bloodPressureLower)
        txtBovendruk.text = "Bovendruk: " + String(measurement.bloodPressureUpper)
        
        txtStatus.font = txtStatus.font.withSize(12)
        setMeasurementFeedback(result: measurement.result, feedback: measurement.feedback)

    }
    
    // Red background color = 0xF8E2E3
    // Red text color       = 0xEB6666
    private func setMeasurementFeedback(result: Int, feedback: String)
    {
        if (result == 0)
        {
            txtStatus.text = feedback
            txtStatus.textColor = UIColor(rgb: 0x35C264)
            self.backgroundColor = UIColor(rgb: 0xE7F6EC)
        }
        else if (result == 1)
        {
            txtStatus.text = feedback
            txtStatus.textColor = UIColor(rgb: 0xB27300)
            self.backgroundColor = UIColor(rgb: 0xFFE4B2)
        }
        else
        {
            txtStatus.text = feedback
            txtStatus.textColor = UIColor(rgb: 0xEB6666)
            self.backgroundColor = UIColor(rgb: 0xF8E2E3)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
