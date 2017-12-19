//
//  MeasurementsDiaryHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyMeasurementsDiaryHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var txtOnderdruk: UILabel!
    @IBOutlet weak var txtBovendruk: UILabel!
    @IBOutlet weak var imgOnderdruk: UIImageView!
    @IBOutlet weak var imgBovendruk: UIImageView!
    @IBOutlet weak var btnMonthly: UIButton!
    @IBOutlet weak var btnWeekly: UIButton!
    @IBOutlet weak var tableViewMeasurements: UITableView!
    
    var lstMeasurements: [Measurement] = []
    let service: MeasurementService = MeasurementService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Mijn Dagboek"
        
        btnWeekly.setTitle("Week overzicht", for: .normal)
        btnWeekly.setTitleColor(UIColor.black, for: .normal)
        btnWeekly.backgroundColor = UIColor(rgb: 0xEEEEEE)
        btnWeekly.layer.cornerRadius = 17
        btnWeekly.layer.borderWidth = 1
        btnWeekly.layer.borderColor = UIColor.black.cgColor
        
        btnMonthly.setTitle("Maand overzicht", for: .normal)
        btnMonthly.setTitleColor(UIColor.black, for: .normal)
        btnMonthly.backgroundColor = UIColor(rgb: 0xFFFFFF)
        btnMonthly.layer.cornerRadius = 17
        btnMonthly.layer.borderWidth = 1
        btnMonthly.layer.borderColor = UIColor.black.cgColor
        
        txtOnderdruk.text = "Onderduk "
        txtOnderdruk.font = txtOnderdruk.font.withSize(12)
        imgOnderdruk.backgroundColor = UIColor(rgb: 0x491488)
        
        txtBovendruk.text = "Bovendruk "
        txtBovendruk.font = txtBovendruk.font.withSize(12)
        imgOnderdruk.backgroundColor = UIColor(rgb: 0x039BE6)
        
        tableViewMeasurements.delegate = self
        tableViewMeasurements.dataSource = self
        
        fetchMeasurements()
    }
    
    private func fetchMeasurements()
    {
        service.getMeasurements(
            withSuccess: { (measurements: [Measurement]) in
                self.lstMeasurements = measurements
                
                DispatchQueue.main.async {
                    self.tableViewMeasurements.reloadData()
                }
        }, orFailure: { (error: String) in
            // Failure
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return lstMeasurements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        customCell.initUserInterface(measurement: lstMeasurements[indexPath.row])
        
        return customCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let viewController = segue.destination as? MyMeasurementDetailsViewController
        {
            let clickedMeasurement = lstMeasurements[self.tableViewMeasurements.indexPathForSelectedRow!.row]
            viewController.clickedMeasurement = clickedMeasurement
        }
    }
    
    @IBAction func btnWeekly_OnClick(_ sender: Any)
    {
        btnWeekly.backgroundColor = UIColor(rgb: 0xEEEEEE)
        btnMonthly.backgroundColor = UIColor(rgb: 0xFFFFFF)
    }
    
    @IBAction func btnMonthly_OnClick(_ sender: Any)
    {
        btnWeekly.backgroundColor = UIColor(rgb: 0xFFFFFF)
        btnMonthly.backgroundColor = UIColor(rgb: 0xEEEEEE)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
