//
//  MeasurementExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 29/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

extension Measurement
{
    func convertToDictionary(withMeasurement measurement: Measurement) -> Dictionary<String, Any> {
        
        return [
            "bloodPressureLower" : measurement.bloodPressureLower,
            "bloodPressureUpper" : measurement.bloodPressureUpper,
            "healthIssueIds" : measurement.healthIssueIds ?? [],
            "healthIssueOther" : measurement.healthIssueOther ?? ""]
            //"measurementDateTime" : measurement.measurementDateTime ?? ""]
    }
}
