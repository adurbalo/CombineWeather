//
//  HourlyWeatherViewController.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 04.01.2021.
//

import Foundation
import Combine
import UIKit

class HourlyWeatherViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var cityID: String = "" {
        didSet {
            self.viewModel.cityID = self.cityID
        }
    }

    var viewModel = HourlyWeatherViewModel()
    var cancellables = Set<AnyCancellable>()

    @Published var itemsCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellIdentifier = String(describing: HourlyCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)

        setupBindings()
    }

    func setupBindings() {

        $itemsCount
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.collectionView.reloadData()
            })
            .store(in: &cancellables)

        viewModel
            .$itemsCount
            .replaceNil(with: 0)
            .assign(to: \.itemsCount, on: self)
            .store(in: &cancellables)
    }
}

extension HourlyWeatherViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return itemsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourlyCollectionViewCell.self),
                                                      for: indexPath) as! HourlyCollectionViewCell
        viewModel.fill(hourlyForecastView: cell, at: indexPath.row)
        return cell
    }
}

extension HourlyWeatherViewController: CityIdentifierReceivable {}
