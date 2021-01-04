//
//  CurrentWeatherViewModel.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import Combine
import UIKit

typealias CityPublisher = AnyPublisher<CityResponse, Error>

class CurrentWeatherViewModel: ObservableObject {

    // MARK: Properties

    //input
    @Published var cityID: String? = nil

    //output
    @Published private(set) var cityName: String?
    @Published private(set) var cityDescription: String?
    @Published private(set) var cityTemperature: String?
    @Published private(set) var cityWeatherIcon: UIImage?

    @Published private var city: CityResponse? = nil

    var cancellables = Set<AnyCancellable>()
    var apiService = APIService()
    var imageProvider = OpenWeatherImageProvider()

    // MARK: Init

    init() {

        setupBinding()
    }

    func setupBinding() {

        $cityID
            .debounce(for: Constants.Combine.defaultDispatchQueueMainDebounceInterval,
                 scheduler: DispatchQueue.main)
            .replaceNil(with: "")
            .filter { !$0.isEmpty }
            .sink { name in
                self.receiveWeather(for: name)
            }.store(in: &cancellables)

        $city
            .compactMap { return $0 }
            .receive(on: DispatchQueue.main)
            .sink { city in

                self.cityName = city.name
                self.cityTemperature = "\(Int(city.main.temp.rounded()))º"

                guard let weather = city.weather.first else { return }
                self.cityDescription = weather.description

                self.imageProvider
                    .openWeatherIcon(by: weather.icon)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { _ in}, receiveValue: { self.cityWeatherIcon = $0 })
                    .store(in: &self.cancellables)

            }.store(in: &cancellables)
    }

    // MARK: Fetch weather

    func receiveWeather(for cityID: String) {

        let endpoint = CurrentWeatherEndpoint.city(id: cityID)
        let publisher: CityPublisher = apiService.fetchModel(endpoint: endpoint)
        publisher
            .sink(receiveCompletion: { _ in }) {
                self.city = $0
            }.store(in: &cancellables)
    }

    func receiveWeather(for lat: Double, lon: Double) {

        let endpoint = CurrentWeatherEndpoint.location(lat: lat, lon: lon)
        let publisher: CityPublisher = apiService.fetchModel(endpoint: endpoint)
        publisher
            .sink(receiveCompletion: { _ in }) {
                self.city = $0
            }.store(in: &cancellables)
    }
}
