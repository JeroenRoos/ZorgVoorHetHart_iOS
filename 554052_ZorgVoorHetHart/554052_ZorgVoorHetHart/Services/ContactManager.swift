//
//  ContactManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class ContactManager
{
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Messages/")

    func sendMessage(withSuccess success: @escaping (String)->(), 
                     orFailure failure: @escaping (String)->(),
                     andSubject subject: String,
                     andMessage message: String)
    {
        
        let parameter: [String: Any] = ["subject" : subject,
                                        "message" : message]
        
        Alamofire.request(baseURL!,
                          method: .post,
                          parameters: parameter,
                          encoding: JSONEncoding.default)
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
                    failure("Er is iets fout gegaan tijdens het sturen van het bericht.")
                }
        }
    }
}
