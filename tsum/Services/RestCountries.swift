//
//  RestCountries.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation

enum RestCountries {
    case all
    case getCountry(name: String)
    case getCountriesByCodes(codes: [String])
}
