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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Meting"
        //self.tabBarItem.title = "Meting"
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
