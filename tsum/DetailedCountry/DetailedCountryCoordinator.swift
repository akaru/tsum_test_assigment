//
//  DetailedCountryCoordinator.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import UIKit
import RxSwift

class DetailedCountryCoordinator: BaseCoordinator<Void> {
    private let navViewController: UINavigationController
    private let networkManager: NetworkManager
    private let countryName: String
    
    init(navViewController: UINavigationController, networkManager: NetworkManager, countryName: String) {
        self.navViewController = navViewController
        self.networkManager = networkManager
        self.countryName = countryName
    }
    override func start() -> Observable<Void> {
        let viewController = DetailedCountryViewController.instantiateFromStoryboard(appStoryBoard: .Main)
        let viewModel = DetailedCountryViewModel(service: networkManager, countryName: countryName)
        viewController.viewModel = viewModel
        
        navViewController.pushViewController(viewController, animated: true)
       
        return Observable.never()
    }
}
