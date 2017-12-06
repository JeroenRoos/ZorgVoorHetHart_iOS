//
//  ConsultantsManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class ConsultantsManager
{
    let baseURL = URL(string: "https://zvh-api.herokuapp.com/Consultants/")
    
    func getConsultans(withSuccess success: @escaping ([Consultant])->(), 
                     orFailure failure: @escaping (String)->())
    {
        Alamofire.request(baseURL!,
                          parameters: nil,
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
                                // Try to decode the received data to a User object
                                let result = try JSONDecoder().decode([Consultant].self, from: data )
                                success(result)
                            }
                            catch
                            {
                                let error: String = "Er is iets fout gegaan tijdens het ophalen van de consulenten."
                                failure(error)
                            }
                        }
                        
                    case .failure(let error):
                        print(error)
                        let error: String = "Er is iets fout gegaan tijdens het ophalen van de consulenten."
                        failure(error)
                    }
        }
    }
}
