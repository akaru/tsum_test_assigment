//
//  UIViewController+Extensions.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import UIKit

extension UIViewController {
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func instantiateFromStoryboard(appStoryBoard: AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
}
