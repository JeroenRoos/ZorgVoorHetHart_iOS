//
//  SessionManager.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 27/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import Alamofire

class MySessionManager: SessionManager
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
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "https://zvh-api.herokuapp.com": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            ),
            "insecure.expired-apis.com": .disableEvaluation
        ]
        
        self.sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    
    // Code from https://infinum.co/the-capsized-eight/how-to-make-your-ios-apps-more-secure-with-ssl-pinning
    /*
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        let serverTrust = challenge.protectionSpace.serverTrust
        let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
        
        // Set SSL policies for domain name check
        let policies = NSMutableArray();
        policies.addObject(SecPolicyCreateSSL(true, (challenge.protectionSpace.host)))
        SecTrustSetPolicies(serverTrust!, policies);
        
        // Evaluate server certificate
        var result: SecTrustResultType = 0
        SecTrustEvaluate(serverTrust!, &result)
        let isServerTrusted:Bool = (Int(result) == kSecTrustResultUnspecified || Int(result) == kSecTrustResultProceed)
        
        var certName = ""
        if self.isSimulatingCertificateCorruption {
            certName = corruptedCert
        } else {
            certName = githubCert
        }
        
        // Get local and remote cert data
        let remoteCertificateData:NSData = SecCertificateCopyData(certificate!)
        let pathToCert = NSBundle.mainBundle().pathForResource(certName, ofType: "cer")
        let localCertificate:NSData = NSData(contentsOfFile: pathToCert!)!
        
        if (isServerTrusted && remoteCertificateData.isEqualToData(localCertificate)) {
            let credential:NSURLCredential = NSURLCredential(forTrust: serverTrust!)
            completionHandler(.UseCredential, credential)
        } else {
            completionHandler(.CancelAuthenticationChallenge, nil)
        }
    }*/
}
