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

class UserManager
{
    private let baseURL = URL(string: "https://zvh-api.herokuapp.com/Users/")
    
    // Try to login an user with an email and password
    func login(withSuccess success: @escaping (User)->(), 
               orFailure failure: @escaping (String)->(),
               andEmail email: String,
               andPassword password: String)
    {
        // Serialize the JSON with email and password
        let url = URL(string: "login", relativeTo: baseURL)
        let parameter: [String: Any] = ["emailAddress" : email,
                                   "password" : password]
        
        Alamofire.request(url!,
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
                            let error: String = "Er is iets fout gegaan tijdens het inloggen."
                            failure(error)
                        }
                    }
                
                case .failure(let error):
                    print(error)
                    failure("Er is iets fout gegaan tijdens het inloggen.")
            }
        }
    }
    
    func register(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
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
                            success("result")
                        }
                        catch
                        {
                            print(response.error!)
                            print(response.result.error!)
                            let error: String = "Er is iets fout gegaan tijdens het registreren."
                            failure(error)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    print(response.error!)
                    print(response.result.error!)
                    failure("Er is iets fout gegaan tijdens het inloggen.")
                }
        }
    }
    
    func updateLengthAndWeight(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andLength length: Int,
                  andWeight weight: Int)
    {
        let parameters: [String: Any] = ["length" : length,
                                         "weight" : weight]
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
                    success("Succes!")
                }
                else
                {
                    print(response.error!)
                    print(response.result.error!)
                    failure("Er is iets fout gegaan tijdens het aanpassen van lengte en gewicht.")
                }
        }
    }
    
    func forgotPassword(withSuccess success: @escaping (String)->(), 
                         orFailure failure: @escaping (String)->(),
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
                    success("Succes!")
                }
                else
                {
                    print(response.error!)
                    print(response.result.error!)
                    failure("Er is iets fout gegaan tijdens het versturen van de email.")
                }
        }
    }
    
    func resetPassword(withSuccess success: @escaping (String)->(), 
                        orFailure failure: @escaping (String)->(),
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
                            success("result")
                        }
                        catch
                        {
                            print(response.error!)
                            print(response.result.error!)
                            let error: String = "Er is iets fout gegaan tijdens het aanpassen van uw wachtwoord."
                            failure(error)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    print(response.error!)
                    print(response.result.error!)
                    failure("Er is iets fout gegaan tijdens het aanpassen van uw wachtwoord")
                }
        }
    }
    
    func activateAccount(withSuccess success: @escaping (String)->(), 
                         orFailure failure: @escaping (String)->(),
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
                    success("Succes!")
                }
                else
                {
                    print(response.error!)
                    print(response.result.error!)
                    failure("Er is iets fout gegaan tijdens het activeren van uw account.")
                }
        }
    }
}
