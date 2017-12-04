//
//  UserManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class UserManager
{
    let baseURL = URL(string: "https://zvh-api.herokuapp.com/Users/")
    
    func login(withSuccess success: @escaping (User)->(), 
               orFailure failure: @escaping (String)->(),
               andUsername username: String,
               andPassword password: String)
    {
        let url = URL(string: "login", relativeTo: baseURL)
        var request = URLRequest(url : url!)
        request.httpMethod = "POST"
        
        let json: [String: Any] = ["emailAddress" : username,
                                   "password" : password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        //let postString = "emailAddress=" + username + "&password=" + password
        //request.httpBody = postString.data(using: .utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler:{(optData: Data?, response: URLResponse?, error: Error?) -> () in  
            
            if let data = optData
            {
                do
                {
                    let result = try JSONDecoder().decode(User.self, from: data)
                    success(result)
                }
                catch
                {
                    let error: String = "Something went wrong while logging in."
                    failure(error)
                }
            }
        })
        
        dataTask.resume()
    }
    
    /*
    let url = URL(string: "Users/login", relativeTo: baseURL)
    var request = URLRequest(url : url!)
    request.httpMethod = "POST"
    let postString = "UserName=" + username + "&Password=" + password
    request.httpBody = postString.data(using: .utf8)
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request, completionHandler:{(optData: Data?, response: URLResponse?, error: Error?) -> () in  
        
        if let data = optData
        {
            do
            {
                let result = try JSONDecoder().decode([String: String].self, from: data)
                
                if (result["AuthToken"] != nil)
                {
                    success(result["AuthToken"]!)
                }
                else
                {
                    failure(result["Message"]!)
                }
            }
            catch
            {
                let error: String = "Something went wrong while logging in."
                failure(error)
            }
        }
    })
    
    dataTask.resume()
 */
    
    func register(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andUser: User)
    {
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
    }
}
