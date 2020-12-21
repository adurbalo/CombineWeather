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

    override func viewDidLoad() {
        super.viewDidLoad()

        bindOutput()
        bindInput()
    }

    // MARK: Binding

    func bindOutput() {

        queryTextField
            .textPublisher
            .assign(to: \.queryCityName, on: viewModel)
            .store(in: &cancellables)
    }

    func bindInput() {

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

