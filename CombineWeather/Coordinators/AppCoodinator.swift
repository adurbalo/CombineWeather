//
//  AppCoodinator.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 06.01.2021.
//

import Foundation
import UIKit

class AppCoodinator {

    let rootViewController: RootViewController

    var navigationController: UINavigationController?

    init(_ vc: RootViewController) {

        self.rootViewController = vc
    }

    func showFirstVC() {

        let citiesListVC: CitiesListViewController = rootViewController.storyboard!.instantiateViewController()
        citiesListVC.delegate = self

        let navigationVC = UINavigationController(rootViewController: citiesListVC)

        rootViewController.add(childVC: navigationVC, toView: rootViewController.view)
        navigationController = navigationVC
    }
}

extension AppCoodinator: CitiesListViewControllerDelegate {

    func didSelect(city: CitiesListViewController.City) {

        let cityContainer = WeatherContainerViewController.instantiate(cityID: city.id)
        navigationController?.pushViewController(cityContainer, animated: true)
    }
}
