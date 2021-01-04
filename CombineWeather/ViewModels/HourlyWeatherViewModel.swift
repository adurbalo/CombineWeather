//
//  HourlyWeatherViewModel.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 04.01.2021.
//

import Foundation
import Combine
import UIKit

//typealias CityPublisher = AnyPublisher<City, Error>

class HourlyWeatherViewModel: ObservableObject {

    //input
    @Published var cityID: String? = nil

    //output
    @Published private(set) var itemsCount: Int?
}
