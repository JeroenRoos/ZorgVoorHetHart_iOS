//
//  UserExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Foundation


extension User
{
   func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(emailAddress, forKey: .emailAddress)
        try container.encode(password, forKey: .password)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(consultantId, forKey: .consultantId)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(gender, forKey: .gender)
    }
}

extension User
{
    func convertToDictionary(withUser user: User) -> Dictionary<String, Any> {
        
        return [
            "emailAddress": user.emailAddress,
            "password": user.password,
            "firstname": user.firstName,
            "lastname": user.lastName,
            "consultantId": user.consultantId,
            "dateOfBirth": user.dateOfBirth,
            "gender": user.gender,
            "length" : user.length,
            "weight" : user.weight
        ]
    }
}
