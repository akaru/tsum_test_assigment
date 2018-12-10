//
//  DetailedCountryViewModel.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailedCountryViewModel {
    let country: Driver<DetailedCountry?>
    let service: NetworkManager
    let disposeBag = DisposeBag()
    
    init(service: NetworkManager, countryName: String) {
        self.service = service
        
        country = service.getDetailedCountry(name: countryName).share(replay: 1).asDriver(onErrorJustReturn: nil)
    }
}
