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

    func receiveWeather(for city: String) -> AnyPublisher<City, Error> {

        let endpoint = CurrentWeatherEndpoint.city(name: city)

        return networking.load(request: endpoint.urlRequest)
            .tryMap {
                return try self.jsonDecoder.decode(City.self, from: $0)
            }.eraseToAnyPublisher()
    }
}
