//
//  Currency.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let code: String
    let name: String
    let symbol: String?
}
