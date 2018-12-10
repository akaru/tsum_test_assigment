//
//  DetailedCountry.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation

struct DetailedCountry: Codable {
    let name: String
    let capital: String
    let population: Int
    let borderedCountriesCodes: [String]
    let currencies: [Currency]
    
     enum CodingKeys: String, CodingKey {
        case name
        case capital
        case population
        case borderedCountriesCodes = "borders"
        case currencies
    }
}
