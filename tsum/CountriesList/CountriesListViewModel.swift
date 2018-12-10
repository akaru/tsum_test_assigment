//
//  CountriesListViewModel.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CountriesListViewModel {
    let countries: Driver<[SimpleCountry]>
    let service: NetworkManager
    let disposeBag = DisposeBag()
    
    init(service: NetworkManager) {
        self.service = service
        countries = service.getCountries().share(replay: 1).asDriver(onErrorJustReturn:[])
        
    }
}
