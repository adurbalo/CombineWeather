//
//  HourlyCollectionViewCell.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 04.01.2021.
//

import Foundation
import UIKit

protocol HourlyForecastView {

    func setTop(text: String?)
    func setMain(text: String?)
    func setBottom(text: String?)
}

class HourlyCollectionViewCell: UICollectionViewCell {


}

extension HourlyCollectionViewCell: HourlyForecastView {

    func setTop(text: String?) {
        
    }

    func setMain(text: String?) {

    }

    func setBottom(text: String?) {

    }
}
