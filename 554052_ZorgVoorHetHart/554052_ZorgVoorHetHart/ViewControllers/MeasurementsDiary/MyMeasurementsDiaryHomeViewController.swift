//
//  MeasurementsDiaryHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Charts

class MyMeasurementsDiaryHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var txtOnderdruk: UILabel!
    @IBOutlet weak var txtBovendruk: UILabel!
    @IBOutlet weak var imgOnderdruk: UIImageView!
    @IBOutlet weak var imgBovendruk: UIImageView!
    @IBOutlet weak var btnMonthly: UIButton!
    @IBOutlet weak var btnWeekly: UIButton!
    @IBOutlet weak var tableViewMeasurements: UITableView!
    
    // Everything BarChart!
    //@IBOutlet weak var barChartView: BarChartView!
    var months: [String]!
    
    var lstMeasurements: [Measurement] = []
    let service: MeasurementService = MeasurementService()
    var updateMeasurements: Bool = false
    
    // SCROLLING
    @IBOutlet weak var myScrollView: UIScrollView!
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    private var showMonthly: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Mijn Dagboek"
        
        //Set table height to cover entire view
        //if navigation bar is not translucent, reduce navigation bar height from view height
        //tableHeight.constant = self.view.frame.height-64
        //tableViewMeasurements.isScrollEnabled = false
        //tableViewMeasurements.contentSize.height = 800 as CGFloat
        //myScrollView.bounces = false
        //tableViewMeasurements.bounces = true
        tableViewMeasurements.delegate = self
        tableViewMeasurements.dataSource = self
        
        
        //myScrollView.contentSize = CGSizeMake(scrollViewContentWidth, scrollViewContentHeight)
        //tableViewMeasurements.bounces = false
        //tableViewMeasurements.scrollEnabled = false
        //myScrollView.bounces = false
        //myScrollView.delegate = self
        
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
        
        //initBarChart()
        fetchMeasurements()
    }
    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView == self.myScrollView
        {
            tableViewMeasurements.isScrollEnabled = (self.myScrollView.contentOffset.y >= 200)
        }
        
        if scrollView == self.tableViewMeasurements
        {
            self.tableViewMeasurements.isScrollEnabled = (tableViewMeasurements.contentOffset.y > 0)
        }
    }*/
    
    override func viewWillAppear(_ animated: Bool)
    {
        if (updateMeasurements)
        {
            lstMeasurements.removeAll()
            fetchMeasurements()
            updateMeasurements = false
        }
    }
    
    private func fetchMeasurements()
    {
        service.getMeasurements(
            withSuccess: { (measurements: [Measurement]) in
                self.lstMeasurements = measurements
                self.lstMeasurements.reverse()
                DispatchQueue.main.async {
                    self.tableViewMeasurements.reloadData()
                }
        }, orFailure: { (error: String) in
            // Failure
        })
    }
    
    /*private func initBarChart()
    {
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(55.0))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(45.0))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(50.0))
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = BarChartData(dataSets: [dataSet])
        barChartView.data = data
        barChartView.chartDescription?.text = "Number of Widgets by Type"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (showMonthly)
        {
            return lstMeasurements.count
        }
        else
        {
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
        
        if (showMonthly)
        {
            showMonthly = false
            tableViewMeasurements.reloadData()
        }
    }
    
    @IBAction func btnMonthly_OnClick(_ sender: Any)
    {
        btnWeekly.backgroundColor = UIColor(rgb: 0xFFFFFF)
        btnMonthly.backgroundColor = UIColor(rgb: 0xEEEEEE)
        
        if (!showMonthly)
        {
            showMonthly = true
            tableViewMeasurements.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
