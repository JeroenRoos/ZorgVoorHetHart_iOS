//
//  HealthIssuesManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 11/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class HealthIssuesManager: MySessionManager
{
    // The base URL for the HealthIssues Manager
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Healthissues/")

    // Get all the Health Issues
    func getHealthIssues(withSuccess success: @escaping ([HealthIssue])->(), 
                       orFailure failure: @escaping (String, String)->())
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The header
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        // GET request with Alamofire using JSONEncoding and Response JSON
        sessionManager?.request(baseURL!,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data
                    {
                        do
                        {
                            // Try to decode the received data to a List of Healthissues objects
                            let result = try JSONDecoder().decode([HealthIssue].self, from: data )
                            
                            success(result)
                        }
                        catch
                        {
                            failure("Er is iets fout gegaan tijdens het ophalen van de gezondheidsproblemen.", "Sorry")
                        }
                    }
                    
                case .failure( _):
                    
                    // Check if the user has an internet connection
                    if (self.isConnectedToInternet)
                    {
                        failure("Er is iets fout gegaan tijdens het ophalen van de gezondheidsproblemen.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
}
