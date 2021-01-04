//
//  ForecastEndpoint.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 22.12.2020.
//

import Foundation

enum ForecastEndpoint {

    case city(id: String)
}

extension ForecastEndpoint: Endpointable {

    var path: String {

        return "forecast"
    }

    var queryParameters: Parameters? {

        switch self {
        case .city(let id):
            return [
                "id": id,
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

