//
//  ConsultantService.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 06/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class ConsultantsService
{
    private let manager: ConsultantsManager = ConsultantsManager()
    
    // Get all the consultants, result is a success or failure callback
    func getConsultans(withSuccess success: @escaping ([Consultant])->(), 
                       orFailure failure: @escaping (String, String)->())
    {
        manager.getConsultans(withSuccess: { (lstConsultants: [Consultant]) in
            success(lstConsultants)
        }, orFailure: { (error: String, title: String) in
            failure(error, title)
        })
    }
}
