//
//  MeasurementService.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MeasurementService
{
    private let manager: MeasurementManager = MeasurementManager()
    
    func postNewMeasurement(withSuccess success: @escaping ()->(), 
                            orFailure failure: @escaping (String, String)->(),
                            andMeasurement measurement: Measurement)
    {
        manager.postNewMeasurement(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andMeasurement: measurement)
    }
    
    func getMeasurements(withSuccess success: @escaping ([Measurement])->(), 
                         orFailure failure: @escaping (String, String)->())
    {
        manager.getMeasurements(withSuccess: { (lstMeasurements: [Measurement]) in
            success(lstMeasurements)
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        })
    }
    
    func updateMeasurement(withSuccess success: @escaping ()->(), 
                           orFailure failure: @escaping (String, String)->(),
                           andMeasurement measurement: Measurement)
    {
        manager.updateMeasurement(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andMeasurement: measurement)
    }
}
