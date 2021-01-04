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

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    var locationService: LocationCombinable = LocationService()

    var viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel()
    var cancellables = Set<AnyCancellable>()

    var cityID: String = "" {
        didSet {
            self.viewModel.cityID = self.cityID
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    // MARK: Binding

    func setupBindings() {

        viewModel
            .$cityName
            .assign(to: \.text, on: locationNameLabel)
            .store(in: &cancellables)

        viewModel
            .$cityDescription
            .assign(to: \.text, on: descriptionLabel)
            .store(in: &cancellables)

        viewModel
            .$cityTemperature
            .assign(to: \.text, on: temperatureLabel)
            .store(in: &cancellables)

        viewModel
            .$cityWeatherIcon
            .assign(to: \.image, on: conditionImageView)
            .store(in: &cancellables)
    }
}

extension CurrentWeatherViewController: CityIdentifierReceivable {}
