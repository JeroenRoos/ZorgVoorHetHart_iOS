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
    private let manager: UserManager = UserManager()
    
    func login(withSuccess success: @escaping (User)->(), 
                  orFailure failure: @escaping (String)->(),
                  andEmail email: String,
                  andPassword password: String)
    {
        manager.login(
            withSuccess: { (user: User) in
                success(user)
        }, orFailure: { (error: String) in
            
        }, andEmail: email, andPassword: password)
    }
    
    func register(withSuccess success: @escaping (String)->(), 
                  orFailure failure: @escaping (String)->(),
                  andUser user: User)
    {
        manager.register(
            withSuccess: { (message: String) in
                success(message)
        }, orFailure: { (error: String) in
                failure(error)
        }, andUser: user)
    }
    
    func updateLengthAndWeight(withSuccess success: @escaping (String)->(), 
                               orFailure failure: @escaping (String)->(),
                               andLength length: Int,
                               andWeight weight: Int)
    {
        manager.updateLengthAndWeight(
            withSuccess: { (message: String) in
                success(message)
        }, orFailure: { (error: String) in
                failure(error)
        }, andLength: length, andWeight: weight)
    }
}
