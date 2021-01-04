//
//  CityResponse.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 17.12.2020.
//

import Foundation

struct CityResponse: Codable {

    let id: Int
    let cod: Int
    let name: String
    let weather: [Weather]
    let main: Main
}

