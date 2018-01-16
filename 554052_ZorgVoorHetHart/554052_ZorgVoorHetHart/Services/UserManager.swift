//
//  UserManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import Alamofire
import UIKit

// Debugging response
// po String(data: response.request!.httpBody!, encoding: String.Encoding.utf8)

class UserManager: MySessionManager
{
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Users/")
    //private var sessionManager: MySessionManager = MySessionManager()
    
    // Try to login an user with an email and password
    func login(withSuccess success: @escaping (User)->(), 
               orFailure failure: @escaping (String, String)->(),
               andEmail email: String,
               andPassword password: String)
    {
        
        // Serialize the JSON with email and password
        configureSSLPinning()
        let url = URL(string: "login", relativeTo: baseURL)
        let parameter: [String: Any] = ["emailAddress" : email,
                                   "password" : password]
        
        // Trying SSL Pinning with Alamofire
        sessionManager?.request(url!,
                          method: .post,
                          parameters: parameter,
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Result: \(response.result)")
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
                
                case .failure(let error):
                    print(error)
                    
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
    
    func register(withSuccess success: @escaping ()->(), 
                  orFailure failure: @escaping (String, String)->(),
                  andUser user: User)
    {
        let url = URL(string: "register", relativeTo: baseURL)
        let dictUser = User().convertToDictionary(withUser: user)
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: dictUser,
                          encoding: JSONEncoding.default)
            .validate() //statusCode: 200 ..< 600)
            .responseJSON { response in
                print("Request: \(String(describing: response.request))")
                print("Result: \(response.result)")
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
                            print(response.error!)
                            print(response.result.error!)
                            failure("Er is iets fout gegaan tijdens het registreren.", "Sorry")
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    print(response.error!)
                    print(response.result.error!)
                    
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
    
    func updateLengthOrWeight(withSuccess success: @escaping ()->(), 
                  orFailure failure: @escaping (String, String)->(),
                  andLength length: Int?,
                  andWeight weight: Int?)
    {
        let parameters: [String: Any] = ["length" : length ?? nil,
                                         "weight" : weight ?? nil]
        let headers: HTTPHeaders = ["x-authtoken" : (User.loggedinUser?.authToken!)!]
        
        Alamofire.request(baseURL!,
                          method: .put,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseString { response in       //responseJSON
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
    
    func forgotPassword(withSuccess success: @escaping ()->(), 
                         orFailure failure: @escaping (String, String)->(),
                         andEmail email: String)
    {
        var url = baseURL!.absoluteString
        url += "forgotPassword?emailAddress=" + email
        
        Alamofire.request(url,
                          method: .post,
                          encoding: JSONEncoding.default)
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
    
    func resetPassword(withSuccess success: @escaping ()->(), 
                        orFailure failure: @escaping (String, String)->(),
                        andPassword password: String,
                        andPasswordCheck confirmPassword: String,
                        andToken token: String)
    {
        let url = URL(string: "resetPassword", relativeTo: baseURL)
        let parameters: [String: Any] = ["password" : password,
                                        "confirmedPassword" : confirmPassword,
                                        "token" : token]
        
        Alamofire.request(url!,
                          method: .put,
                          parameters: parameters,
                          encoding: JSONEncoding.default)
            .validate() 
            .responseJSON { response in
                print("Request: \(String(describing: response.request))")
                print("Result: \(response.result)")
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
                            print(response.error!)
                            print(response.result.error!)
                            failure("Er is iets fout gegaan tijdens het aanpassen van uw wachtwoord.", "Sorry")
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    print(response.error!)
                    print(response.result.error!)
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
    
    func activateAccount(withSuccess success: @escaping ()->(), 
                         orFailure failure: @escaping (String, String)->(),
                         andToken token: String)
    {
        var url = baseURL!.absoluteString
        url += "activate?token=" + token
        
        
        Alamofire.request(url,
                          encoding: JSONEncoding.default)
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
