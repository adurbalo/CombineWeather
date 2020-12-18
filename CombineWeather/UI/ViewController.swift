//
//  ViewController.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 17.12.2020.
//

import UIKit
import Combine
import CombineCocoa

import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    var weatherFetcher = CurrentWeatherFetcher()

    var locationService: LocationCombinable = LocationService()

    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //loadData()

        setupBindings()
    }

    func setupBindings() {

        queryTextField
            .textPublisher
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .replaceNil(with: "")
            .filter { !$0.isEmpty }
            .sink {
                self.resultTextView.text = $0
                self.loadData(for: $0)
            }.store(in: &cancellables)

        locationService.authorizationPublisher()
            .sink { (status) in

                switch status {
                case .restricted, .denied:
//                    self.showFetchLocationError()
                    print("Unable to fetch LOCATION, check settings")
                case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
                    self.locationService.startUpdatingLocation()
                @unknown default:
                    break
                }
            }.store(in: &cancellables)

        locationService.locationPublisher()
            .map { location in
                return ( location.coordinate.latitude, location.coordinate.longitude )
            }
            .sink {
                self.loadData(for: $0.0, lon: $0.1)
            }.store(in: &cancellables)
    }

    func loadData(for city: String) {

        weatherFetcher.receiveWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data in
            self.render(city: data)
        }.store(in: &cancellables)
    }

    func loadData(for lat: Double, lon: Double) {

        weatherFetcher.receiveWeather(for: lat, lon: lon)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data in
                self.render(city: data)
        }.store(in: &cancellables)
    }

    func render(city: City) {

        resultTextView.text = city.name

        locationNameLabel.text = city.name
        descriptionLabel.text = city.weather.first?.description

        temperatureLabel.text = "\(city.main.temp.rounded()) º"

        if let icon = city.weather.first?.icon {
            let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")!
            URLSession.shared.dataTaskPublisher(for: url)
                .mapError({$0 as Error})
                .map(\.data)
                .map(UIImage.init)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in }) { result in
                    self.conditionImageView.image = result
                }.store(in: &cancellables)
        }
    }
}

