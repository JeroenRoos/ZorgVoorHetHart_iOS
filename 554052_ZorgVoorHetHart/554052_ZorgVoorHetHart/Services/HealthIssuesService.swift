//
//  HealthIssuesService.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 11/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class HealthIssuesService
{
    private let manager: HealthIssuesManager = HealthIssuesManager()
    
    // Gets all the Health Issues, result is a success or failure callback
    func getHealthIssues(withSuccess success: @escaping ([HealthIssue])->(), 
                       orFailure failure: @escaping (String, String)->())
    {
        manager.getHealthIssues(withSuccess: { (lstHealthIssues: [HealthIssue]) in
            success(lstHealthIssues)
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        })
    }
}
