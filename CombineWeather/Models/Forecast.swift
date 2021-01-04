//
//  Forecast.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 04.01.2021.
//

import Foundation

struct Forecast: Codable {

    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
}
