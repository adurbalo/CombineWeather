//
//  ForecastEndpoint.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 22.12.2020.
//

import Foundation

enum ForecastEndpoint {

    case name(name: String)
}

extension ForecastEndpoint: Endpointable {

}
