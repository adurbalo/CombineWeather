//
//  NetworkTypes.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 17.12.2020.
//

import Foundation
import Combine

typealias Parameters = [String: AnyHashable]

enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
}

protocol Endpointable {

    var baseURL: URL { get }
    var path: String { get }
    var queryParameters: Parameters? { get }
    var body: Data? { get }
    var httpMethod: HTTPMethod { get }
    var urlRequest: URLRequest { get }
}

extension Endpointable {

    var baseURL: URL {

        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }

    var urlRequest: URLRequest {

        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)

        if let parameters = queryParameters, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {

            let queryItems = parameters.compactMap {
                return URLQueryItem(name: $0, value: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            }
            components.queryItems = queryItems
            request.url = components.url
        }

        if let body = body {
            request.httpBody = body
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue

        return request
    }
}

protocol NetworkingProtocol {

    func load(request: URLRequest) -> AnyPublisher<Data, Error>
}

extension URLSession: NetworkingProtocol {

    func load(request: URLRequest) -> AnyPublisher<Data, Error> {

        print(request)

        return dataTaskPublisher(for: request)
            .mapError({$0 as Error})
            .map(\.data)
            .handleEvents(receiveOutput: {
                let string = String(data: $0, encoding: .utf8) ?? "NO RESPONSE"
                print(string)
            })
            .eraseToAnyPublisher()
    }
}
