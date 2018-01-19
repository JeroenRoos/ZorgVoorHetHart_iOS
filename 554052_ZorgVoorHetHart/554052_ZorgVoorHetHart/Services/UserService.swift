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
    
    // Login a user with an email and password, result will be success of failure callback with the proper data
    func login(withSuccess success: @escaping (User)->(), 
                  orFailure failure: @escaping (String, String)->(),
                  andEmail email: String,
                  andPassword password: String)
    {
        manager.login(withSuccess: { (user: User) in
            success(user)
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andEmail: email,
           andPassword: password)
    }
    
    // Register an user with an User, result will be success of failure callback with the proper data
    func register(withSuccess success: @escaping ()->(), 
                  orFailure failure: @escaping (String, String)->(),
                  andUser user: User)
    {
        manager.register(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andUser: user)
    }
    
    // Update the length or weight of a user, result will be success of failure callback with the proper data
    func updateLengthOrWeight(withSuccess success: @escaping ()->(), 
                               orFailure failure: @escaping (String, String)->(),
                               andLength length: Int?,
                               andWeight weight: Int?)
    {
        manager.updateLengthOrWeight(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andLength: length,
           andWeight: weight)
    }
    
    // Call that will send a email with the token needed to reset the password of the user, result will be success of failure callback with the proper data
    func forgotPassword(withSuccess success: @escaping ()->(), 
                        orFailure failure: @escaping (String, String)->(),
                        andEmail email: String)
    {
        manager.forgotPassword(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andEmail: email)
    }
    
    // Call that actually resets the password, result will be success of failure callback with the proper data
    func resetPassword(withSuccess success: @escaping ()->(), 
                       orFailure failure: @escaping (String, String)->(),
                       andPassword password: String,
                       andPasswordCheck confirmPassword: String,
                       andToken token: String)
    {
        manager.resetPassword(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andPassword: password,
           andPasswordCheck: confirmPassword,
           andToken: token)
    }
    
    // Call that activates the account of the user, result will be success of failure callback with the proper data
    func activateAccount(withSuccess success: @escaping ()->(), 
                         orFailure failure: @escaping (String, String)->(),
                         andToken token: String)
    {
        manager.activateAccount(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andToken: token)
    }
}
