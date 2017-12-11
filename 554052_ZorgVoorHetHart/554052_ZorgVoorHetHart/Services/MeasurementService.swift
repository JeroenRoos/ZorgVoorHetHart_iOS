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
    
    func postNewMeasurement(withSuccess success: @escaping (String)->(), 
                            orFailure failure: @escaping (String)->(),
                            andMeasurement measurement: Measurement)
    {
        manager.postNewMeasurement(withSuccess: { (message: String) in
            success(message)
        }, orFailure: { (error: String) in
            failure(error)
        }, andMeasurement: measurement)
    }

}
