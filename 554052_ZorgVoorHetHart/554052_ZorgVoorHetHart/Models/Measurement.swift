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
    var measurementDateTime: String = ""
    var measurementDateTimeFormatted: String = ""
    
    enum CodingKeys: String, CodingKey
    {
        case measurementId = "_id"
        case bloodPressureLower = "bloodPressureLower"
        case bloodPressureUpper = "bloodPressureUpper"
        case healthIssueIds = "healthIssuesIds"
        case healthIssueOther = "healthIssueOther"
        case userId = "userId"
        case measurementDateTime = "measurementDateTime"
        case measurementDateTimeFormatted = "measurementDateFormatted"
    }

}
