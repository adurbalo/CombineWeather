//
//  CurrentWeatherEndpoint.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 17.12.2020.
//

import Foundation

enum CurrentWeatherEndpoint {
    case name(name: String)
    case location(lat: Double, lon: Double)
}

extension CurrentWeatherEndpoint: Endpointable {

    var path: String {
        return "weather"
    }

    var queryParameters: Parameters? {
        switch self {
        case .name(let name):
            return [
                "q": name,
                "units": "metric",
                "lang": "ua"
                    ]
        case .location(let lat, let lon):
            return [
                "lat": String(lat),
                "lon": String(lon),
                "units": "metric"
                    ]
        }
    }

    var body: Data? {
        return nil
    }

    var httpMethod: HTTPMethod {
        return .get
    }
}
