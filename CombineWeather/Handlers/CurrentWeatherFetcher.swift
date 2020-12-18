//
//  CurrentWeatherFetcher.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 17.12.2020.
//

import Foundation
import Combine

class CurrentWeatherFetcher {

    let networking: NetworkingProtocol
    var jsonDecoder = JSONDecoder()
    var cancellables = Set<AnyCancellable>()

    init(networking: NetworkingProtocol = URLSession.shared) {
        self.networking = networking
    }

    func receiveWeather(for name: String) -> AnyPublisher<City, Error> {

        let endpoint = CurrentWeatherEndpoint.name(name: name)

        return networking.load(request: endpoint.urlRequest)
            .tryMap {
                return try self.jsonDecoder.decode(City.self, from: $0)
            }.eraseToAnyPublisher()
    }

    func receiveWeather(for lat: Double, lon: Double) -> AnyPublisher<City, Error> {

        let endpoint = CurrentWeatherEndpoint.location(lat: lat, lon: lon)

        return networking.load(request: endpoint.urlRequest)
            .tryMap {
                return try self.jsonDecoder.decode(City.self, from: $0)
            }.eraseToAnyPublisher()
    }
}
