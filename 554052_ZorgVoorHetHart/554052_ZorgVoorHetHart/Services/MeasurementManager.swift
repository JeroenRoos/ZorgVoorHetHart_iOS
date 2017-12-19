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
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Measurements/")

    func postNewMeasurement(withSuccess success: @escaping (String)->(), 
                               orFailure failure: @escaping (String)->(),
                               andMeasurement measurement: Measurement)
    {
        let parameters: [String: Any] = ["bloodPressureLower" : measurement.bloodPressureLower,
                                         "bloodPressureUpper" : measurement.bloodPressureLower,
                                         "healthIssuesIds" : measurement.healthIssueIds ?? [],
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
    
    func getMeasurements(withSuccess success: @escaping ([Measurement])->(), 
                         orFailure failure: @escaping (String)->())
    {
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        Alamofire.request(baseURL!,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result
                {
                case .success:
                    if let data = response.data
                    {
                        do
                        {
                            // Try to decode the received data to a List of Measurement objects
                            let result = try JSONDecoder().decode([Measurement].self, from: data )
                            success(result)
                        }
                        catch
                        {
                            let error: String = "Er is iets fout gegaan tijdens het ophalen van de metingen."
                            failure(error)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    let error: String = "Er is iets fout gegaan tijdens het ophalen van de metingen."
                    failure(error)
                }
        }
    }
    
    func updateMeasurement(withSuccess success: @escaping (String)->(), 
                           orFailure failure: @escaping (String)->(),
                           andMeasurement measurement: Measurement)
    {
        let parameters: [String: Any] = ["bloodPressureLower" : measurement.bloodPressureLower,
                                         "bloodPressureUpper" : measurement.bloodPressureLower,
                                         "healthIssuesIds" : measurement.healthIssueIds ?? [],
                                         "healthIssueOther" : measurement.healthIssueOther ?? "",]
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        Alamofire.request(baseURL!,
                          method: .put,
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
                    failure("Er is iets fout gegaan tijdens het aanpassen van de meting.")
                }
        }
    }
}
