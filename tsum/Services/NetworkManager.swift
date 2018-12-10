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
    
    func getCountries() -> Observable<[SimpleCountry]> {
        return provider.rx
            .request(.all)
            .map([SimpleCountry].self)
            .asObservable()
    }
    
    func getDetailedCountry(name: String) -> Observable<DetailedCountry?> {
        return provider.rx
        .request(.getCountry(name: name))
            .map([DetailedCountry].self).map{ array in
                array.first
            }
            .asObservable()
    }
}
