//
//  UserExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Foundation

/*
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
}*/

/*
extension User: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        emailAddress = try values.decode(String.self, forKey: .emailAddress)
        password = try values.decode(String.self, forKey: .password)
        authToken = try values.decode(String.self, forKey: .authToken)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        consultantId = try values.decode(String.self, forKey: .consultantId)
        dateOfBirth = try values.decode(Date.self, forKey: .dateOfBirth)
        gender = try values.decode(Int.self, forKey: .gender)
        length = try values.decode(Int.self, forKey: .length)
        weight = try values.decode(Int.self, forKey: .weight)
        resetPasswordToken = try values.decode(String.self, forKey: .resetPasswordToken)
        isActivated = try values.decode(Bool.self, forKey: .isActivated)
        activationToken = try values.decode(String.self, forKey: .activationToken)
    }
}*/
