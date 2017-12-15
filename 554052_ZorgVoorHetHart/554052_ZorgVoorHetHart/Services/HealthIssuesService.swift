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
    
    func getHealthIssues(withSuccess success: @escaping ([HealthIssue])->(), 
                       orFailure failure: @escaping (String)->())
    {
        manager.getHealthIssues(withSuccess: { (lstHealthIssues: [HealthIssue]) in
            success(lstHealthIssues)
        }, orFailure: { (error: String) in
            failure(error)
        })
    }
}
