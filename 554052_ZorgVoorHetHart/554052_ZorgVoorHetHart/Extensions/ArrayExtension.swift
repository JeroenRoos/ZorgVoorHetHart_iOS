//
//  ArrayExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 19/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

extension Array where Element : HealthIssue
{
    func filterHealthIssueForId(id : String) -> Element
    {
        var issue: HealthIssue? = nil
        for i in 0 ..< self.count
        {
            if (self[i].issueId == id)
            {
                issue = self[i]
                break
            }
        }
        
        return issue as! Element
    }
}
