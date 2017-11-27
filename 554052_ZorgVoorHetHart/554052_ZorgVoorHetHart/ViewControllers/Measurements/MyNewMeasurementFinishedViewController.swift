//
//  MyNewMeasurementFinishedViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 27/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyNewMeasurementFinishedViewController: UIViewController
{
    @IBOutlet weak var btnCheckDiary: UIButton!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtInfo: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Nieuwe meting afgerond"
        
        btnCheckDiary.setTitle("Bekijk dagboek", for: .normal)
        btnCheckDiary.setTitleColor(UIColor.white, for: .normal)
        btnCheckDiary.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        txtTitle.text = "Uw meting is succesvol opgeslagen in uw dagboek!"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        txtInfo.text = "U kunt gemakkelijk een overzicht van al uw metingen zien onder dagboek"
        txtInfo.font = txtInfo.font.withSize(12)
    }
    
    @IBAction func btnCheckDiary_OnClick(_ sender: Any)
    {
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.selectedIndex = 1
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
