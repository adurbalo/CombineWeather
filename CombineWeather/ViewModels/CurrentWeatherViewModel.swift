//
//  CurrentWeatherViewModel.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import Combine

typealias CityPublisher = AnyPublisher<City, Error>

class CurrentWeatherViewModel: ObservableObject {

    // MARK: Properties

    //input
    @Published var cityName: String? = nil

    //output
    @Published var city: City? = nil

    var cancellables = Set<AnyCancellable>()
    var apiService = APIService()

    // MARK: Init

    init() {

        setupBinding()
    }

    func setupBinding() {

        $cityName
            .debounce(for: Constants.Combine.defaultDispatchQueueMainDebounceInterval,
                 scheduler: DispatchQueue.main)
            .replaceNil(with: "")
            .filter { !$0.isEmpty }
            .sink { name in
                self.receiveWeather(for: name)
            }.store(in: &cancellables)
    }

    // MARK: Fetch weather

    func receiveWeather(for name: String) {

        let endpoint = CurrentWeatherEndpoint.name(name: name)
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
