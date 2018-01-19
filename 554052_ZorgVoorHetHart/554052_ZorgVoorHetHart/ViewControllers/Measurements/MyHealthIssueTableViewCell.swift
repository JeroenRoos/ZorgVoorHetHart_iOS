//
//  MyHealthIssueTableViewCell.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 14/01/2018.
//  Copyright © 2018 Jeroen Roos. All rights reserved.
//

import UIKit

class MyHealthIssueTableViewCell: UITableViewCell
{
    @IBOutlet weak var checkboxHealthIssue: CheckboxHelper!
    
    // Initialize the UI for this cell
    func initCheckbox(healthIssue: HealthIssue)
    {
        checkboxHealthIssue.setTitle(healthIssue.name, for: .normal)
        checkboxHealthIssue.setTitleColor(UIColor.black, for: .normal)
        
        // Set the health issue ID in the identifier of the checkbox
        checkboxHealthIssue.accessibilityIdentifier = healthIssue.issueId
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
