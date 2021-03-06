//
//  HealthIssue.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 11/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class HealthIssue : Decodable
{
    static var healthIssuesInstance = [HealthIssue]()
    private init() {}
    
    var issueId: String = ""                 // ObjectId
    var name: String = ""
    
    // Coding keys, A type that can be used as a key for coding/encoding
    enum CodingKeys: String, CodingKey
    {
        case issueId = "_id"
        case name = "name"
    }
}
