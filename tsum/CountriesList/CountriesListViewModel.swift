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
    let showCountry = PublishSubject<SimpleCountry>()
    var isRefreshing: Observable<Bool>!
    private let refreshProperty = BehaviorSubject<Bool>(value: true)
    private let service: NetworkManager
    private let disposeBag = DisposeBag()
    
    init(service: NetworkManager) {
        self.service = service
        isRefreshing = refreshProperty.asObservable()
        let loadCountries = isRefreshing
            .flatMapLatest { isRefreshing -> Observable<[SimpleCountry]> in
                guard isRefreshing else { return .empty() }
                return service.getCountries()
            }.catchError {[refreshProperty] (error) -> Observable<[SimpleCountry]> in
                refreshProperty.onNext(false)
                return .empty()
        }
        
        countries = loadCountries.share(replay: 1).do(onNext: { [refreshProperty] (_) in
            refreshProperty.onNext(false)
        }).asDriver(onErrorJustReturn:[])
        
    }
    
    func refresh() {
        refreshProperty.onNext(true)
    }
}
