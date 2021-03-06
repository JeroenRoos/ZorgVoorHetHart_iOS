//
//  Measurement.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 11/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class Measurement: Decodable
{
    var measurementId: String = ""                 // ObjectId
    var bloodPressureLower: Int = 0
    var bloodPressureUpper: Int = 0
    var healthIssueIds: [String]?
    var healthIssueOther: String?
    var userId: String = ""                         // ObjectId
    var measurementDateTimeFormatted: String = ""
    var feedback : String = ""
    var result: Int = 0
    
    // Coding keys, A type that can be used as a key for coding/encoding
    enum CodingKeys: String, CodingKey
    {
        case measurementId = "_id"
        case bloodPressureLower = "bloodPressureLower"
        case bloodPressureUpper = "bloodPressureUpper"
        case healthIssueIds = "healthIssueIds"
        case healthIssueOther = "healthIssueOther"
        case userId = "userId"
        case measurementDateTimeFormatted = "measurementDateFormatted"
        case feedback = "feedback"
        case result = "result"
    }

}
