//
//  SessionManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 27/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class SessionManager
{
    class var isConnectedToInternet: Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
    
    /*
    static let instance = SessionManager()
    
    func listenForReachability()
    {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
        reachabilityManager?.listener = {status in
            switch status {
            case .notReachable:
                print("You do not have an internet connection.")
                
            case .reachable(_), .unknown:
                print("You have an internet connection!")
            }
            
        reachabilityManager?.startListening()
        }
    } */
}
