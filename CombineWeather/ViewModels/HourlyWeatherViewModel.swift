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

    private var hourlyForecast: HourlyForecast?

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
            }) {
                self.hourlyForecast = $0
                self.itemsCount = $0.list.count
            }.store(in: &cancellables)
    }

    func fill(hourlyForecastView: HourlyForecastView, at index: Int) {

        guard let forecast = hourlyForecast else { return }

        let hf = forecast.list[index]

        hourlyForecastView.setTop(text: time(forest: forecast, index: index))
        hourlyForecastView.setMain(text: hf.weather.first?.main)
        hourlyForecastView.setBottom(text: "\(Int(hf.main.temp.rounded()))º")
    }

    func time(forest: HourlyForecast, index: Int) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "H"

        let date = Date(timeIntervalSince1970: forest.list[index].dt)

        return dateFormatter.string(from: date)
    }
}
