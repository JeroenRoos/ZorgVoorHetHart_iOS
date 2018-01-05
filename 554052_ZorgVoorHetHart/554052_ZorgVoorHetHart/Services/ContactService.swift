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
    private let manager: ContactManager = ContactManager()
    
    func sendMessage(withSuccess success: @escaping ()->(), 
                     orFailure failure: @escaping (String, String)->(),
                     andSubject subject: String,
                     andMessage message: String)
    {
        manager.sendMessage(withSuccess: { () in
            success()
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        }, andSubject: subject, andMessage: message)
    }

}
