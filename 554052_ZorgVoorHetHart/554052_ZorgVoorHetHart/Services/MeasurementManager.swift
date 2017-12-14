//
//  MeasurementManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import Alamofire
import UIKit

class MeasurementManager
{
    let baseURL = URL(string: "https://zvh-api.herokuapp.com/Measurements/")

    func postNewMeasurement(withSuccess success: @escaping (String)->(), 
                               orFailure failure: @escaping (String)->(),
                               andMeasurement measurement: Measurement)
    {
        let parameters: [String: Any] = ["bloodPressureLower" : measurement.bloodPressureLower,
                                         "bloodPressureUpper" : measurement.bloodPressureLower,
                                         "healthIssuesIds" : measurement.healthIssuesIds,
                                         "healthIssueOther" : measurement.healthIssueOther ?? "",]
        
        let headers = ["x-authtoken" : User.loggedinUser?.authToken ?? ""]
        
        Alamofire.request(baseURL!,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseString { response in
                print("Request: \(response.request!)")
                print("Response: \(String(describing: response.response))")
                print("Result: \(response.result)")
                
                if (response.result.isSuccess)
                {
                    success("Succes!")
                }
                else
                {
                    print(response.error!)
                    print(response.result.error!)
                    failure("Er is iets fout gegaan tijdens het aanpassen van lengte en gewicht.")
                }
        }
    }
}
