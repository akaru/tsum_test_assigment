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
    private let country = BehaviorSubject<DetailedCountry?>(value: nil)
    private let service: NetworkManager
    private let disposeBag = DisposeBag()
    
    private let countryNameSubject: BehaviorSubject<String>
    let countryNameDriver: Driver<String>
    private let capitalSubject = BehaviorSubject(value: "Capital:")
    let capitalDriver: Driver<String>
    private let populationSubject = BehaviorSubject(value: "Population:")
    let populationDriver: Driver<String>
    private let borderedCountriesSubject = BehaviorSubject(value: "Bordered countries:")
    let borederedCountriesDriver: Driver<String>
    private let currenciesSubject = BehaviorSubject(value: "Currencies:")
    let currenciesDriver: Driver<String>
    
    init(service: NetworkManager, countryName: String) {
        self.service = service
        let getCountry = service.getDetailedCountry(name: countryName)
            .share(replay: 1).do( onError: { (error) in
                print(error.localizedDescription)
            })
        
        
        let getBorderedCountries = getCountry.flatMap{Observable.from(optional: $0)}.flatMap { [service] in
            service.getCountriesByCodes($0.borderedCountriesCodes)
        }
        
        Observable.combineLatest(getCountry, getBorderedCountries).map { (arg0) -> DetailedCountry? in
            
            var (country, borders) = arg0
            var countrieNames = [String]()
            for borderCountry in borders {
                countrieNames.append(borderCountry.name)
            }
           
            country?.borderedCountriesNames = countrieNames
            return country
        }.bind(to: country).disposed(by: disposeBag)
        
        
        countryNameSubject = BehaviorSubject(value: countryName)
        country.flatMap{Observable.from(optional: $0)}.map { (country) in
            country.name
            }.bind(to: self.countryNameSubject).disposed(by: disposeBag)
        countryNameDriver = countryNameSubject.asDriver(onErrorJustReturn: countryName)
        
        country.flatMap{Observable.from(optional: $0)}.map { (country) in
            let capitalName = country.capital.isEmpty ? "unknown" : country.capital
            return "Capital: \(capitalName)"
            }.bind(to: capitalSubject).disposed(by: disposeBag)
        capitalDriver = capitalSubject.asDriver(onErrorJustReturn: "Capital: unknown")
        
        country.flatMap{Observable.from(optional: $0)}.map { (country) in
            "Population: \(country.population)"
            }.bind(to: populationSubject).disposed(by: disposeBag)
        populationDriver = populationSubject.asDriver(onErrorJustReturn: "Population: unknown")
        
        country.flatMap{Observable.from(optional: $0)}.map { (country) -> String in
            var countries = [String]()
            if let borderedCountriesNames = country.borderedCountriesNames {
                for countryName in borderedCountriesNames {
                    countries.append(countryName)
                }
            }
            let result = countries.count > 0 ? countries.joined(separator: ", ") : "none"
            return "Bordered countries: \(result)"
            }.bind(to: borderedCountriesSubject).disposed(by: disposeBag)
        borederedCountriesDriver = borderedCountriesSubject.asDriver(onErrorJustReturn: "Bordered countries: none")
        
        country.flatMap{Observable.from(optional: $0)}.map { (country) -> String in
            var currencies = [String]()
            for currency in country.currencies {
                currencies.append(currency.name)
            }
            let resultString = currencies.count > 0 ? currencies.joined(separator: ", ") : "unknown"
            return "Currencies: \(resultString)"
            }.bind(to: currenciesSubject).disposed(by: disposeBag)
        currenciesDriver = currenciesSubject.asDriver(onErrorJustReturn: "Currencies: unknown")
        
    }
}
