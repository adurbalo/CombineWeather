//
//  HourlyForecast.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 22.12.2020.
//

import Foundation

struct HourlyForecast: Codable {

    let city: City
    let list: [Forecast]
}
