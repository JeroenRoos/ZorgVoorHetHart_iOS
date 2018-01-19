//
//  MeasurementsDiaryHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import SwiftSpinner

class MyMeasurementsDiaryHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var btnMonthly: UIButton!
    @IBOutlet weak var btnWeekly: UIButton!
    @IBOutlet weak var tableViewMeasurements: UITableView!
    
    private var lstMeasurements: [Measurement] = []
    private let service: MeasurementService = MeasurementService()
    var updateMeasurements: Bool = false
    private var showMonthly: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Mijn Dagboek"
     
        // Set the tableview delegates
        tableViewMeasurements.delegate = self
        tableViewMeasurements.dataSource = self
    
        // Initialize the User Interface for this ViewController
        initUserInterface()
        
        // Fetch the measurements from the database
        fetchMeasurements()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        // Deselect the selected TableView row to remove the grey collor from the selected row
        if (tableViewMeasurements.indexPathForSelectedRow != nil)
        {
            tableViewMeasurements.deselectRow(at: tableViewMeasurements.indexPathForSelectedRow!, animated: false)
        }
        
        // If the measurements need to be updated (determined when completing a measurement) remove all the entries and fetch all the measurements again. This is needed because the feedback and status of the measurement are determined in the API
        if (updateMeasurements)
        {
            lstMeasurements.removeAll()
            fetchMeasurements()
            updateMeasurements = false
        }
    }
    
    // Fetch all the measurements from the database
    private func fetchMeasurements()
    {
        SwiftSpinner.show("Bezig met het ophalen van uw metingen...")
        
        // The request to fetch all the measurements, result will be success or failure
        service.getMeasurements(
            withSuccess: { (measurements: [Measurement]) in
                self.lstMeasurements = measurements
                
                // Reload the table view data
                DispatchQueue.main.async {
                    self.tableViewMeasurements.reloadData()
                }
                SwiftSpinner.hide()
        }, orFailure: { (error: String, title: String) in
            SwiftSpinner.hide()
            self.showAlertBox(withMessage: error, andTitle: title)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // If the user wants to see all the measurements from the last month
        if (showMonthly)
        {
            return lstMeasurements.count
        }
        else
        {
            // If the user only wants to see the last 7 or less days of measurements
            if (lstMeasurements.count < 7)
            {
                return lstMeasurements.count
            }
            else
            {
                return 7
            }
        }
    }
    
    // Initialize the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Get the cell
        let customCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        // Initialize the UI of the cell
        customCell.initUserInterface(measurement: lstMeasurements[indexPath.row])
        
        return customCell
    }
    
    // Prepare the data for the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let viewController = segue.destination as? MyMeasurementDetailsViewController
        {
            let clickedMeasurement = lstMeasurements[self.tableViewMeasurements.indexPathForSelectedRow!.row]
            viewController.clickedMeasurement = clickedMeasurement
        }
    }
    
    // Called when the weekly measurements button is clicked
    @IBAction func btnWeekly_OnClick(_ sender: Any)
    {
        btnWeekly.backgroundColor = UIColor(rgb: 0xEEEEEE)
        btnMonthly.backgroundColor = UIColor(rgb: 0xFFFFFF)
        
        // Set the table view row number and reload the data in the tableview
        if (showMonthly)
        {
            showMonthly = false
            tableViewMeasurements.reloadData()
        }
    }
    
    // Called when the monthly measurements button is clicked
    @IBAction func btnMonthly_OnClick(_ sender: Any)
    {
        btnWeekly.backgroundColor = UIColor(rgb: 0xFFFFFF)
        btnMonthly.backgroundColor = UIColor(rgb: 0xEEEEEE)
        
        // Set the tableview row number and reload the data in the tableview
        if (!showMonthly)
        {
            showMonthly = true
            tableViewMeasurements.reloadData()
        }
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        btnWeekly.setTitle("Week overzicht", for: .normal)
        btnWeekly.setTitleColor(UIColor.black, for: .normal)
        btnWeekly.backgroundColor = UIColor(rgb: 0xEEEEEE)
        btnWeekly.layer.borderWidth = 1
        btnWeekly.layer.borderColor = UIColor.black.cgColor
        
        btnMonthly.setTitle("Maand overzicht", for: .normal)
        btnMonthly.setTitleColor(UIColor.black, for: .normal)
        btnMonthly.backgroundColor = UIColor(rgb: 0xFFFFFF)
        btnMonthly.layer.borderWidth = 1
        btnMonthly.layer.borderColor = UIColor.black.cgColor
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
