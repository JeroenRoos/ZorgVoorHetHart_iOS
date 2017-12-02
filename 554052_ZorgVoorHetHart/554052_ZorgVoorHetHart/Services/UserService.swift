//
//  UserService.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class UserService
{
    let manager: UserManager = UserManager()
    
    func login(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andUsername username: String,
                  andPassword password: String)
    {
        
    }
    
    func register(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andUsername username: String,
                  andPassword password: String)
    {
        
    }
}
