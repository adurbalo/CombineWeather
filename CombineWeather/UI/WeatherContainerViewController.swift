//
//  WeatherContainerViewController.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import UIKit
import SnapKit

protocol CityIdentifierReceivable: AnyObject {

    var cityID: String { get set }
}

class WeatherContainerViewController: UIViewController {

// MARK: Properties

    @IBOutlet weak var currentWeatherContainerView: UIView!
    @IBOutlet weak var hourlyWeatherContainerView: UIView!

    lazy var currentWeatherVC: CurrentWeatherViewController = {
        return storyboard!.instantiateViewController()
    }()

    lazy var hourlyWeatherVC: HourlyWeatherViewController = {
        return storyboard!.instantiateViewController()
    }()

    var childs: [CityIdentifierReceivable] = []

    // MARK: Override

    override func viewDidLoad() {
        super.viewDidLoad()

        configureChilds()

        let cityId = "698740" // Odessa
        setCity(id: cityId)
    }

    // MARK: Internal

    func configureChilds() {

        append(childVC: currentWeatherVC, toView: currentWeatherContainerView)
        childs.append(currentWeatherVC)

        append(childVC: hourlyWeatherVC, toView: hourlyWeatherContainerView)
        childs.append(hourlyWeatherVC)
    }

    func setCity(id: String) {

        childs.forEach { $0.cityID = id }
    }
}
