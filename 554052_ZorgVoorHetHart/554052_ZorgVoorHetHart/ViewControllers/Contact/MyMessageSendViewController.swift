//
//  MyMessageSendViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 27/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyMessageSendViewController: UIViewController
{
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtInfo: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Bericht verzonden"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }

    // Called when the user presses the "Klaar" button
    @IBAction func btnDone_OnClick(_ sender: Any)
    {
        self.tabBarController!.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        btnDone.setTitle("Klaar", for: .normal)
        btnDone.setTitleColor(UIColor.white, for: .normal)
        btnDone.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        txtTitle.text = "Uw bericht is verzonden!"
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        txtInfo.text = "Uw consulent zal binnenkort contact met u opnemen."
        txtInfo.font = txtInfo.font.withSize(12)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
