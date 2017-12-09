//
//  ContactService.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class ContactService
{
    let manager: ContactManager = ContactManager()
    
    func sendMessage(withSuccess success: @escaping (String)->(), 
                     orFailure failure: @escaping (String)->(),
                     andSubject subject: String,
                     andMessage message: String,
                     andUserId userId: String)
    {
        manager.sendMessage(withSuccess: { (message: String) in
            success(message)
        }, orFailure: { (error: String) in
            failure(message)
        }, andSubject: subject, andMessage: message, andUserId: userId)
    }

}
