//
//  RequestResult.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import Foundation

//Это из нереализованных задумок. Модель данных, которая возвращалась бы со всех типов нетворк запросов
enum RequestResult<T,E> {
    case success(T)
    case error(E)
}
