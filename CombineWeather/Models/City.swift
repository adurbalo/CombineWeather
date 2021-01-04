//
//  City.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 04.01.2021.
//

import Foundation

struct City: Codable {

    let id: Int
    let name: String
    let country: String
    let timezone: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
}
