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
    
    func login(withSuccess success: @escaping (User)->(), 
                  orFailure failure: @escaping (String)->(),
                  andUsername username: String,
                  andPassword password: String)
    {
        manager.login(
            withSuccess: { (user: User) in
                success(user)
        }, orFailure: { (error: String) in
            
        }, andUsername: username, andPassword: password)
    }
    
    func register(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andUser: User)
    {
        manager.register(
            withSuccess: { (message: String) in
                // Success code
        }, orFailure: { (error: String) in
                // Failure code
        }, andUser: andUser)
    }
}
