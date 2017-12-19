//
//  User.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Foundation

class User : Codable
{
    static var loggedinUser: User? = nil
    
    var userId: String = ""                 // ObjectId
    var emailAddress: String = ""
    var password: String = ""
    var authToken: String?
    var firstName: String = ""
    var lastName: String = ""
    var consultantId: String = ""         // ObjectId
    var dateOfBirth: String = ""
    var gender: Int = 0
    var length: Int = 0
    var weight: Int = 0
    var resetPasswordToken: String?
    var isActivated: Bool = false
    var activationToken: String = ""
    
    enum CodingKeys: String, CodingKey
    {
        case userId = "_id"
        case emailAddress = "emailAddress"
        case password = "password"
        case authToken = "authToken"
        case firstName = "firstname"
        case lastName = "lastname"
        case consultantId = "consultantId"
        case dateOfBirth = "dateOfBirth"
        case gender = "gender"
        case length = "length"
        case weight = "weight"
        case resetPasswordToken = "resetPasswordToken"
        case isActivated = "isActivated"
        case activationToken = "activationToken"
    }
}
