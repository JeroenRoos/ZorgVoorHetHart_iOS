//
//  MeasurementHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 20/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyMeasurementHomeViewController: UIViewController
{
    @IBOutlet weak var txtSquareMiddle: UILabel!
    @IBOutlet weak var txtUpperBar: UILabel!
    @IBOutlet weak var btnNewMeasurement: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Meting"
        
        btnNewMeasurement.setTitle("Start nieuwe meting", for: .normal)
        btnNewMeasurement.setTitleColor(UIColor.white, for: .normal)
        btnNewMeasurement.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        txtUpperBar.text = "Goedenmiddag [patient]"
        txtUpperBar.font = txtUpperBar.font.withSize(14)
        
        
        txtSquareMiddle.text = "Vul uw eerste meting in"
        txtSquareMiddle.font = txtSquareMiddle.font.withSize(11)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
