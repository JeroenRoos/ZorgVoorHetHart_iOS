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

    func postNewMeasurement(withSuccess success: @escaping ()->(), 
                               orFailure failure: @escaping (String, String)->(),
                               andMeasurement measurement: Measurement)
    {
        let parameters = Measurement().convertToDictionary(withMeasurement: measurement)
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
                    success()
                }
                else
                {
                    print(response.error!)
                    print(response.result.error!)

                    if (SessionManager.isConnectedToInternet)
                    {
                    failure("Er is iets fout gegaan tijdens het aanpassen van lengte en gewicht.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
    
    func getMeasurements(withSuccess success: @escaping ([Measurement])->(), 
                         orFailure failure: @escaping (String, String)->())
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
                            failure("Er is iets fout gegaan tijdens het ophalen van de metingen.", "Sorry")
                        }
                    }
                    
                case .failure(let error):
                    print(error)

                    if (SessionManager.isConnectedToInternet)
                    {
                        failure("Er is iets fout gegaan tijdens het ophalen van de metingen.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
    
    func updateMeasurement(withSuccess success: @escaping ()->(), 
                           orFailure failure: @escaping (String, String)->(),
                           andMeasurement measurement: Measurement)
    {
        var parameters = Measurement().convertToDictionary(withMeasurement: measurement)
        parameters.updateValue(measurement.measurementId, forKey: "_id")
        
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
                    success()
                }
                else
                {
                    print(response.error!)
                    print(response.result.error!)

                    if (SessionManager.isConnectedToInternet)
                    {
                        failure("Er is iets fout gegaan tijdens het aanpassen van de meting.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
}
