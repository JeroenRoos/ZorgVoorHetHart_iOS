//
//  UINavigationControllerExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 28/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension of NavigationController - completion handler for popToRootViewController
extension UINavigationController
{
    public func popToRootViewController(animated: Bool,
                                        completion: (() -> Void)?)
    {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
