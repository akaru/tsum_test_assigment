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
    private var navViewController: UINavigationController?
    private let networkManager: NetworkManager
    
    init(window: UIWindow) {
        self.window = window
        self.networkManager = NetworkManager()
        
    }
    
    override func start() -> Observable<Void> {
        let viewController = CountriesListViewController.instantiateFromStoryboard(appStoryBoard: .Main)
        let viewModel = CountriesListViewModel(service: networkManager)
        
        viewModel.showCountry.flatMap { [weak self] (country) -> Observable<Void> in
            guard let `self` = self else { return .empty() }
            return self.showCountry(country)
        }.subscribe()
            .disposed(by: disposeBag)
        
        viewController.viewModel = viewModel
        
        //Мне не очень нравится, как я сделал обработку ошибок, в идеале нужно сделать поэлегантнее и пореактивнее. Возможно зареактивить алерт контроллер и добавить ему свою вьюмодель
        self.networkManager.getCountriesError.subscribe(onNext: { (error) in
            let vc = UIAlertController(title: "Error", message: "There was a trouble fetching countries list. \(error.localizedDescription)", preferredStyle: .alert)
            let alertAction = UIAlertAction(
                title: "Ok",
                style: .cancel,
                handler: nil)
            vc.addAction(alertAction)
            viewController.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        self.navViewController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navViewController
        window.makeKeyAndVisible()
        return Observable.never()
    }
    
    func showCountry(_ country: SimpleCountry) -> Observable<Void> {
        let detailedCountryCoordinator = DetailedCountryCoordinator(navViewController: self.navViewController!, networkManager: networkManager, countryName: country.name)
        return coordinate(to: detailedCountryCoordinator)
    }
    
}
