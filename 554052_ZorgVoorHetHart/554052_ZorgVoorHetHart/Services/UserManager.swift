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
    let baseURL = URL(string: "https://inhollandbackend.azurewebsites.net/api/")
    
    func register(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andUsername username: String,
                  andPassword password: String)
    {
        
    }
    
    func login(withSuccess success: @escaping (String)->(), 
               orFailure failure: @escaping (String)->(),
               andUsername username: String,
               andPassword password: String)
    {
        
    }
}
