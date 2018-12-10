//
//  NetworkManager.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class NetworkManager {
    private let provider = MoyaProvider<RestCountries>()
    let getCountriesError = PublishSubject<Error>()
    let getCountryDetailsError = PublishSubject<Error>()
    let getCountriesByCodesError = PublishSubject<Error>()
    
    func getCountries() -> Observable<[SimpleCountry]> {
        return provider.rx
            .request(.all)
            .map([SimpleCountry].self)
            .catchError({ [weak self] (error) in
                self?.getCountriesError.onNext(error)
                return .just([])
            })
            .asObservable()
    }
    
    func getDetailedCountry(name: String) -> Observable<DetailedCountry?> {
        return provider.rx
        .request(.getCountry(name: name))
            .map([DetailedCountry].self).map{ array in
                array.first
            }
            .catchError({ [weak self] (error) in
                self?.getCountryDetailsError.onNext(error)
                return .just(nil)
            })
            .asObservable()
    }
    
    func getCountriesByCodes(_ codes: [String]) -> Observable<[SimpleCountry]> {
        return provider.rx
            .request(.getCountriesByCodes(codes: codes)).do(onSuccess: { (response) in
                print(response)
            })
            .map([SimpleCountry].self)
            .catchError({ [weak self] (error) in
                self?.getCountriesByCodesError.onNext(error)
                return .just([])
            })
            .asObservable()
    }
}
