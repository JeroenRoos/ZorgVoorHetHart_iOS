//
//  ContactManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class ContactManager: MySessionManager
{
    // The base URL for the ContactManager
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Messages/")

    // Send a message to a consultant with an subject and email
    func sendMessage(withSuccess success: @escaping ()->(), 
                     orFailure failure: @escaping (String, String)->(),
                     andSubject subject: String,
                     andMessage message: String)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The header and parameters for the request
        let parameter: [String: Any] = ["subject" : subject,
                                        "message" : message]
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        // POST request with Alamofire using JSONEncoding and Response String
        sessionManager?.request(baseURL!,
                          method: .post,
                          parameters: parameter,
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
                    if (self.isConnectedToInternet)
                    {
                        failure("Er is iets fout gegaan tijdens het sturen van het bericht.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
}
