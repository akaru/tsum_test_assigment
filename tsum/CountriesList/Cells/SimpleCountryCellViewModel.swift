//
//  SimpleCountryCellViewModel.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SimpleCountryCellViewModel {
    private let country: BehaviorSubject<SimpleCountry>
    
    let countryName: Driver<String>
    let countryPopulation: Driver<String>
    private let disposeBag = DisposeBag()
    
    init(country: SimpleCountry) {
        self.country = BehaviorSubject(value: country)
        self.countryName = self.country
            .map { country in
                country.name
            }.asDriver(onErrorJustReturn: "")
        
        self.countryPopulation = self.country
            .map { country in
                "Population: \(country.population)"
            }.asDriver(onErrorJustReturn: "Population: unknown")
        
    }
}
