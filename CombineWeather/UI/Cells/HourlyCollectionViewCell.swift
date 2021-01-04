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

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        resetViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetViews()
    }

    func resetViews() {

        [topLabel, mainLabel, bottomLabel].forEach {
            $0?.text = nil
        }
    }
}

extension HourlyCollectionViewCell: HourlyForecastView {

    func setTop(text: String?) {
        topLabel.text = text
    }

    func setMain(text: String?) {
        mainLabel.text = text
    }

    func setBottom(text: String?) {
        bottomLabel.text = text
    }
}
