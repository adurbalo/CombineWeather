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

    private(set) var cityID: String!

    var childs: [CityIdentifierReceivable] = []

    // MARK: Init

    static func instantiate(cityID: String) -> WeatherContainerViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: WeatherContainerViewController = storyboard.instantiateViewController()
        vc.cityID = cityID
        return vc
    }

    // MARK: Override

    override func viewDidLoad() {
        super.viewDidLoad()

        configureChilds()

        setCity(id: cityID)
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
