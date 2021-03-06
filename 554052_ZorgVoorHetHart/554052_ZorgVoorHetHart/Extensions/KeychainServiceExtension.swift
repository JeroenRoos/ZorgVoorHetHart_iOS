//
//  KeychainServiceExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 24/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension of the KeychainService to have a place to get the service and accounts from
extension KeychainService
{
    var passwordService: String
    {
        return "ZvhHKeychainPasswordService"
    }
    
    var emailService: String
    {
        return "ZvhHKeychainEmailService"
    }
    
    var consultantService: String
    {
        return "ZvhHKeychainConsultantService"
    }
    
    var keychainAccount: String
    {
        return "ZvhHLoggedinAccount"
    }
}
