//
//  APIService.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import Combine

class APIService {

    var networking: NetworkingProtocol = URLSession.shared
    var jsonDecoder = JSONDecoder()

    func fetchModel<T: Decodable>(endpoint: Endpointable) -> AnyPublisher<T, Error> {

        return networking
            .load(request: endpoint.urlRequest)
            .tryMap {
                return try self.jsonDecoder.decode(T.self, from: $0)
            }.eraseToAnyPublisher()

    }
}
