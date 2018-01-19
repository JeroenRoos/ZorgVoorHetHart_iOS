//
//  SessionManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 27/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class MySessionManager
{
    // Check for an Internet connection, according to Alamofire documentation you should not use Reachability to deterime if a network request should be sent. You should always send it.
    var isConnectedToInternet: Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }

    // SSL Pinning
    var sessionManager: SessionManager? = nil
    
    func configureSSLPinning()
    {
        // Add the API to the serverTrustPolicies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "https://zvh-api.herokuapp.com": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            )
        ]
        
        self.sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
}
