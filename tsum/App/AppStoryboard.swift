//
//  AppStoryboard.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    case Main
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass: T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardId) as? T else {
            fatalError("ViewController with identifier \(storyboardId), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
