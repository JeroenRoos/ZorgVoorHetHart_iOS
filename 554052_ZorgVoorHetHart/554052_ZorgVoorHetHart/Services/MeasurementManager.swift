//
//  MeasurementManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import Alamofire
import UIKit

class MeasurementManager: MySessionManager
{
    // The base URL for the Measurement Manager
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Measurements/")

    // Request which posts a new measurement, result will be a success of failure callback
    func postNewMeasurement(withSuccess success: @escaping ()->(), 
                               orFailure failure: @escaping (String, String)->(),
                               andMeasurement measurement: Measurement)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The parameters and header for the request
        let parameters = Measurement().convertToDictionary(withMeasurement: measurement)
        let headers = ["x-authtoken" : User.loggedinUser?.authToken ?? ""]
        
        // POST request with Alamofire using JSONEncoding and Response String
        sessionManager?.request(baseURL!,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseString { response in
                
                if (response.result.isSuccess)
                {
                    success()
                }
                else
                {
                    // Check if the user has an internet connection
                    if (self.isConnectedToInternet)
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
    
    // Request gets all the measurement, result will be a success of failure callback
    func getMeasurements(withSuccess success: @escaping ([Measurement])->(), 
                         orFailure failure: @escaping (String, String)->())
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The header for the request
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        // GET request with Alamofire using JSONEncoding and Response JSON
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
                    
                case .failure( _):
                    // Check if the user has an internet connection
                    if (self.isConnectedToInternet)
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
    
    // Request which updates a measurement, result will be a success of failure callback
    func updateMeasurement(withSuccess success: @escaping ()->(), 
                           orFailure failure: @escaping (String, String)->(),
                           andMeasurement measurement: Measurement)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The parameters and header for the request
        var parameters = Measurement().convertToDictionary(withMeasurement: measurement)
        parameters.updateValue(measurement.measurementId, forKey: "_id")
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        // PUT request with Alamofire using JSONEncoding and Response String
        sessionManager?.request(baseURL!,
                          method: .put,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseString { response in
                
                if (response.result.isSuccess)
                {
                    success()
                }
                else
                {
                    // Check if the user has an internet connection
                    if (self.isConnectedToInternet)
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
