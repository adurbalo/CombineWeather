//
//  WeatherContainerViewController.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import UIKit
import SnapKit

class WeatherContainerViewController: UIViewController {

// MARK: Properties

    @IBOutlet weak var currentWeatherContainerView: UIView!

    lazy var currentWeatherVC: CurrentWeatherViewController = {
        return storyboard!.instantiateViewController()
    }()

    // MARK: Override

    override func viewDidLoad() {
        super.viewDidLoad()

        addCurrentWeather()
    }

    // MARK: Internal

    func addCurrentWeather() {

        append(childVC: currentWeatherVC, toView: currentWeatherContainerView)
    }
}
