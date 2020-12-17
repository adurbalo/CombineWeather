//
//  CurrentWeatherEndpoint.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 17.12.2020.
//

import Foundation

enum CurrentWeatherEndpoint {
    case city(name: String)
}

extension CurrentWeatherEndpoint: Endpointable {

    var path: String {
        switch self {
        case .city(_):
            return "weather"
        }
    }

    var queryParameters: Parameters? {
        switch self {
        case .city(let name):
            return [
                "q": name,
                "appid": ""
                    ]
        }
    }

    var body: Data? {
        return nil
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .city(_):
            return .get
        }
    }
}
