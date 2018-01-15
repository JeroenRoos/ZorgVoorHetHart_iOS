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
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Healthissues/")

    func getHealthIssues(withSuccess success: @escaping ([HealthIssue])->(), 
                       orFailure failure: @escaping (String, String)->())
    {
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        Alamofire.request(baseURL!,
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
                    
                case .failure(let error):
                    print(error)
                    
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
