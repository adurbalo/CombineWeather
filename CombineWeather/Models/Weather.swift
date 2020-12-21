//
//  Weather.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 18.12.2020.
//

import Foundation

struct Weather: Codable, Identifiable {

    let id: Int
    let main: String
    let description: String
    let icon: String
}
