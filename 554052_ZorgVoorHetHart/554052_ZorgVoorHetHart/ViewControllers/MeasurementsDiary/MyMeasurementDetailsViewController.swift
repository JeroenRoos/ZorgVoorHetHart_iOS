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
    var clickedMeasurement: Measurement? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // (Date().getCurrentWeekdayAndDate())
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
