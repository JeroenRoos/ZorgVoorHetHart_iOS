//
//  UIScrollViewExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 15/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension of the UIScrollView, this extension allows me to scroll to the top of View(Controller) 
extension UIScrollView
{
    func scrollToTop(animated: Bool)
    {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
}
