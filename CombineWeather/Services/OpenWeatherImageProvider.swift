//
//  OpenWeatherImageProvider.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import UIKit
import Combine

typealias ImagePublisher = AnyPublisher<UIImage?, Error>

class OpenWeatherImageProvider {

    // MARK: Properties

    var networking: NetworkingProtocol = URLSession.shared

    // MARK: Private

    private func imageData(by url: URL) -> ImagePublisher {

        return networking
            .load(request: URLRequest.init(url: url))
            .map(UIImage.init)
            .eraseToAnyPublisher()
    }

    // MARK: Internal

    func openWeatherIcon(by id: String) -> ImagePublisher {

        let url = URL(string: "http://openweathermap.org/img/wn/\(id)@2x.png")!
        return imageData(by: url)
    }
}
