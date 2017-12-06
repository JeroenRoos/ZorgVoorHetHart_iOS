//
//  UserManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import Alamofire
import UIKit

class UserManager
{
    let baseURL = URL(string: "https://zvh-api.herokuapp.com/Users/")
    
    // Try to login an user with an email and password
    func login(withSuccess success: @escaping (User)->(), 
               orFailure failure: @escaping (String)->(),
               andEmail email: String,
               andPassword password: String)
    {
        // Serialize the JSON with email and password
        let url = URL(string: "login", relativeTo: baseURL)
        let json: [String: Any] = ["emailAddress" : email,
                                   "password" : password]
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: json,
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
        let dictUser = User().convertToDictionary(user: user)
        
        let json: [String: Any] = ["emailAddress": "test@test.com",
                                "lastName": "Test",
                                "firstName": "Jeroen",
                                "consultantId": "5a0336f35f9123e60146b7d3",
                                "dateOfBirth": "14-07-2017",
                                "gender": 1,
                                "password": "test"]
        
        let jsonUser: Data = try! JSONEncoder().encode(user)
        
        Alamofire.request(url!,
                          method: .post,
                          parameters: dictUser,
                          encoding: JSONEncoding.default)
            .validate()
            .responseString { response in       //responseJSON
                print("Request: \(String(describing: response.request))")
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
                    failure("Er is iets fout gegaan tijdens het inloggen.")
                }
        }
    }
    
    func updateLengthAndWeight(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andLength length: Int,
                  andWeight weight: Int)
    {
        let json: [String: Any] = ["length" : length,
                                   "weight" : weight]
        
        Alamofire.request(baseURL!,
                          method: .put,
                          parameters: json,
                          encoding: JSONEncoding.default)
            .validate()
            .responseString
 
    }
    
    /*
     let url = URL(string: "register", relativeTo: baseURL)
     var request = URLRequest(url : url!)
     request.httpMethod = "POST"
     
     do
     {
     let userData: Data = try JSONEncoder().encode(andUser)
     request.httpBody = userData
     }
     catch
     {
     print(error)
     }
     
     let session = URLSession.shared
     let dataTask = session.dataTask(with: request, completionHandler:{(optData: Data?, response: URLResponse?, error: Error?) -> () in  
     
     if (error == nil)
     {
     success("Succes!")
     }
     else
     {
     let error: String = "Er is iets fout gegaan tijdens het registreren van uw account."
     failure(error)
     }
     
     })
     
     dataTask.resume()
     */
}

// Login Native Swift Style
/*
let url = URL(string: "login", relativeTo: baseURL)
var request = URLRequest(url : url!)
request.httpMethod = "POST"

// Serialize the JSON with email and password and add to the httpBody
let json: [String: Any] = ["emailAddress" : email,
                           "password" : password]
let jsonData = try? JSONSerialization.data(withJSONObject: json)
request.httpBody = jsonData

let session = URLSession.shared
let dataTask = session.dataTask(with: request, completionHandler:{(optData: Data?, response: URLResponse?, error: Error?) -> () in  
    
    if let data = optData
    {
        do
        {
            // Try to decode the received data to a User object
            let result = try JSONDecoder().decode(User.self, from: data)
            
            // Return the user object in the success callback
            success(result)
        }
        catch
        {
            // Return an error message in the failure callback
            let error: String = "Er is iets fout gegaan tijdens het inloggen."
            failure(error)
        }
    }
})

dataTask.resume()
 */
