//
//  UserManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import Alamofire
import UIKit

class UserManager: MySessionManager
{
    // Base URL for the UserManager
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Users/")
    
    // Try to login an user with an email and password, result will be a success or failure callback with the proper data
    func login(withSuccess success: @escaping (User)->(), 
               orFailure failure: @escaping (String, String)->(),
               andEmail email: String,
               andPassword password: String)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // Set the URL and the paramters
        let url = URL(string: "login", relativeTo: baseURL)
        let parameter: [String: Any] = ["emailAddress" : email,
                                   "password" : password]
        
        // POST request with Alamofire JSONEncoding and Response JSON
        sessionManager?.request(url!,
                          method: .post,
                          parameters: parameter,
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
                            let result = try JSONDecoder().decode(User.self, from: data )
                            success(result)
                        }
                        catch
                        {
                            failure("Er is iets fout gegaan tijdens het inloggen.", "Sorry")
                        }
                    }
                
            case .failure( _):
                    // Check if the user has an internet connection
                    if (self.isConnectedToInternet)
                    {
                        failure("Er is iets fout gegaan tijdens het inloggen.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
            }
        }
    }
    
    // Try to register an user, result will be a success or failure callback with the proper data
    func register(withSuccess success: @escaping ()->(), 
                  orFailure failure: @escaping (String, String)->(),
                  andUser user: User)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The URl and a dictionary from the user as parameters
        let url = URL(string: "register", relativeTo: baseURL)
        let dictUser = User().convertToDictionary(withUser: user)
        
        // POST request with Alamofire using JSONEncoding and Response JSON
        sessionManager?.request(url!,
                          method: .post,
                          parameters: dictUser,
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
                            _ = try JSONDecoder().decode(User.self, from: data )
                            success()
                        }
                        catch
                        {
                            failure("Er is iets fout gegaan tijdens het registreren.", "Sorry")
                        }
                    }
                    
                case .failure( _):
                    // Check if the user has an internet connection
                    if (self.isConnectedToInternet)
                    {
                        failure("Er is iets fout gegaan tijdens het registreren.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
    
    // Try to update the weight or length of a user, result will be a success or failure callback with the proper data
    func updateLengthOrWeight(withSuccess success: @escaping ()->(), 
                  orFailure failure: @escaping (String, String)->(),
                  andLength length: Int?,
                  andWeight weight: Int?)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The parameters and header for the request
        let parameters: [String: Any] = ["length" : length ?? nil,
                                         "weight" : weight ?? nil]
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
                        failure("Er is iets fout gegaan tijdens het aanpassen van lengte en gewicht.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
    
    // Request that send the email to the user during the reset password process, result will be a success or failure callback with the proper data
    func forgotPassword(withSuccess success: @escaping ()->(), 
                         orFailure failure: @escaping (String, String)->(),
                         andEmail email: String)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The parameters for the request
        var url = baseURL!.absoluteString
        url += "forgotPassword?emailAddress=" + email
        
        // POST request with Alamofire using JSONEncoding and Response String
        sessionManager?.request(url,
                          method: .post,
                          encoding: JSONEncoding.default)
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
                        failure("Er is iets fout gegaan tijdens het versturen van de email.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
    
    // The request that resets the password, result will be a success or failure callback with the proper data
    func resetPassword(withSuccess success: @escaping ()->(), 
                        orFailure failure: @escaping (String, String)->(),
                        andPassword password: String,
                        andPasswordCheck confirmPassword: String,
                        andToken token: String)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The parameters and URL for the request
        let url = URL(string: "resetPassword", relativeTo: baseURL)
        let parameters: [String: Any] = ["password" : password,
                                        "confirmedPassword" : confirmPassword,
                                        "token" : token]
        
        // PUT request with Alamofire using JSONEncoding and Response JSON
        sessionManager?.request(url!,
                          method: .put,
                          parameters: parameters,
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
                            _ = try JSONDecoder().decode(User.self, from: data )
                            success()
                        }
                        catch
                        {
                            failure("Er is iets fout gegaan tijdens het aanpassen van uw wachtwoord.", "Sorry")
                        }
                    }
                    
                case .failure( _):
                    // Check if the user has an internet connection
                    if (self.isConnectedToInternet)
                    {
                        failure("Er is iets fout gegaan tijdens het aanpassen van uw wachtwoord", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
    
    // The request that activates the account of a user, result will be a success or failure callback with the proper data
    func activateAccount(withSuccess success: @escaping ()->(), 
                         orFailure failure: @escaping (String, String)->(),
                         andToken token: String)
    {
        // Configure the SSL Pinning
        configureSSLPinning()
        
        // The URL for the request
        var url = baseURL!.absoluteString
        url += "activate?token=" + token
        
        // GET request with Alamofire using JSONEncoding and Response String
        sessionManager?.request(url,
                          encoding: JSONEncoding.default)
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
                        failure("Er is iets fout gegaan tijdens het activeren van uw account.", "Sorry")
                    }
                    else
                    {
                        failure("U heeft geen internet verbinding.", "Helaas")
                    }
                }
        }
    }
}
