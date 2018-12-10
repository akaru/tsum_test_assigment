//
//  CountriesListCoordinator.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import UIKit
import RxSwift

class CountriesListCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewController = CountriesListViewController.instantiateFromStoryboard(appStoryBoard: .Main)
        let viewModel = CountriesListViewModel(service: NetworkManager())
        viewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return Observable.never()
    }
}
