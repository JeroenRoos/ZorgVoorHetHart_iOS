//
//  HealthIssuesManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 11/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class HealthIssuesManager
{
    let baseURL = URL(string: "https://zvh-api.herokuapp.com/Healthissues/")

    func getHealthIssues(withSuccess success: @escaping ([HealthIssue])->(), 
                       orFailure failure: @escaping (String)->())
    {
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        Alamofire.request(baseURL!,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers)
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
                            // Try to decode the received data to a List of Healthissues objects
                            let result = try JSONDecoder().decode([HealthIssue].self, from: data )
                            success(result)
                        }
                        catch
                        {
                            let error: String = "Er is iets fout gegaan tijdens het ophalen van de gezondheidsproblemen."
                            failure(error)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    let error: String = "Er is iets fout gegaan tijdens het ophalen van de gezondheidsproblemen."
                    failure(error)
                }
        }
    }
}
