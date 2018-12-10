//
//  RestCountriesTargetType.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Moya

extension RestCountries: TargetType {
    var baseURL: URL {
        return URL(string: "https://restcountries.eu/rest/v2")!
    }
    
    var path: String {
        switch self {
        case .all:
            return "/all"
        case .getCountry(let name):
            return "/name/\(name)"
        case .getCountriesByCodes(_):
            return "/alpha"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .all, .getCountry, .getCountriesByCodes:
            return .get
        }
        
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .all, .getCountry:
            return .requestPlain
        case .getCountriesByCodes(let codes):
            var params: [String: Any] = [:]
            params["codes"] = codes.joined(separator: ";")
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
