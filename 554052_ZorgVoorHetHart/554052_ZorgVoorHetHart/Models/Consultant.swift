//
//  Consultant.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class Consultant : Decodable
{
    var consultantId: String = ""                 // ObjectId
    var firstName: String = ""
    var lastName: String = ""
    var emailAddress: String = ""
    
    enum CodingKeys: String, CodingKey
    {
        case consultantId = "_id"
        case firstName = "firstname"
        case lastName = "lastname"
        case emailAddress = "emailAddress"
    }
}
