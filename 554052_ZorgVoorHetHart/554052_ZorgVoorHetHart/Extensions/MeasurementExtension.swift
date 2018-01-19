//
//  MeasurementExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 29/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension to convert the Measurement Model Class to a dictionary. This dictionary is used for Alamofire parameters
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
