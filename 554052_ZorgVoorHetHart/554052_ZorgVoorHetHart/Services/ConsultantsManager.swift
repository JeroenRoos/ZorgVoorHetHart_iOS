//
//  ConsultantsManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class ConsultantsManager: MySessionManager
{
    // The base URL for the Consultant Manager
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Consultants/")
    
    // Get all the consultants, result is a success or failure callback
    func getConsultans(withSuccess success: @escaping ([Consultant])->(), 
                     orFailure failure: @escaping (String, String)->())
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // GET request with Alamofire using JSONEncoding and Response JSON
        sessionManager?.request(baseURL!,
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result
                {
                    // Response code 200 ..< 300
                    case .success:
                        if let data = response.data
                        {
                            do
                            {
                                // Try to decode the received data to a List of Consultans object
                                let result = try JSONDecoder().decode([Consultant].self, from: data )
                                success(result)
                            }
                            catch
                            {
                                failure("Er is iets fout gegaan tijdens het ophalen van de consulenten.", "Sorry")
                            }
                        }
                        
                    case .failure( _):
                       
                        // Check if the user has an internet connection
                        if (self.isConnectedToInternet)
                        {
                            failure("Er is iets fout gegaan tijdens het ophalen van de consulenten.", "Sorry")
                        }
                        else
                        {
                            failure("U heeft geen internet verbinding.", "Helaas")
                        }
                }
        }
    }
}
