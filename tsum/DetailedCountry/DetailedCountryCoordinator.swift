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
        
        //Мне не очень нравится, как я сделал обработку ошибок, в идеале нужно сделать поэлегантнее и пореактивнее. Возможно зареактивить алерт контроллер и добавить ему свою вьюмодель
        Observable.merge(networkManager.getCountryDetailsError.asObservable(),
                         networkManager.getCountriesByCodesError.asObservable())
            .take(1)
            .subscribe(onNext: { (error) in
                let vc = UIAlertController(title: "Error", message: "There was a trouble fetching country details. \(error.localizedDescription)", preferredStyle: .alert)
                let alertAction = UIAlertAction(
                    title: "Ok",
                    style: .cancel,
                    handler: nil)
                vc.addAction(alertAction)
                viewController.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        navViewController.pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
}
