//
//  HourlyWeatherViewModel.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 04.01.2021.
//

import Foundation
import Combine
import UIKit

typealias HourlyForecastPublisher = AnyPublisher<HourlyForecast, Error>

class HourlyWeatherViewModel: ObservableObject {

    //input
    @Published var cityID: String? = nil

    //output
    @Published private(set) var itemsCount: Int?

    var cancellables = Set<AnyCancellable>()
    var apiService = APIService()

    private var hourlyForecast: [HourlyForecastViewRepresentation] = []

    // MARK: Init

    init() {

        setupBinding()
    }

    // MARK: Internal

    func setupBinding() {

        $cityID
            .debounce(for: Constants.Combine.defaultDispatchQueueMainDebounceInterval,
                 scheduler: DispatchQueue.main)
            .replaceNil(with: "")
            .filter { !$0.isEmpty }
            .sink { id in
                self.receiveWeather(for: id)
            }.store(in: &cancellables)
    }

    // MARK: Fetch weather

    func receiveWeather(for cityID: String) {

        let endpoint = ForecastEndpoint.city(id: cityID)
        let publisher: HourlyForecastPublisher = apiService.fetchModel(endpoint: endpoint)
        publisher
            .sink(receiveCompletion: { result in

                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }) { hf in
                self.hourlyForecast = hf.list.compactMap {
                    return HourlyForecastViewRepresentation(forecast: $0, city: hf.city)
                }
                self.itemsCount = self.hourlyForecast.count
            }.store(in: &cancellables)
    }

    func fill(hourlyForecastView: HourlyForecastView, at index: Int) {

        let viewRepresentation = hourlyForecast[index]

        hourlyForecastView.setTop(text: viewRepresentation.time)
        hourlyForecastView.setMain(text: viewRepresentation.condition)
        hourlyForecastView.setBottom(text: viewRepresentation.temperature)
    }
}

struct HourlyForecastViewRepresentation {

    let time: String?
    let condition: String?
    let temperature: String?
}

extension HourlyForecastViewRepresentation {

    init(forecast: Forecast, city: City) {

        let date = Date(timeIntervalSince1970: forecast.dt)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(city.timezone) - TimeZone.current.secondsFromGMT() )

        var calendar = Calendar.current
        calendar.timeZone = dateFormatter.timeZone

        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "E, HH:mm"
        }

        condition = forecast.weather.first?.main
        temperature = "\(Int(forecast.main.temp.rounded()))º"
    }
}
