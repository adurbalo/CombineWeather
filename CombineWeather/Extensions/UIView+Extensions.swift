//
//  UIView+Extensions.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import UIKit

extension UIView {

    func appendAsBottomSubview(_ subview: UIView) {

        var allSubviews = subviews
            .sorted { $0.frame.minY < $1.frame.minY }
        
        addSubview(subview)
        allSubviews.append(subview)

        var prevView: UIView? = nil

        for (index, view) in allSubviews.enumerated() {

            let lastView = index == (allSubviews.count - 1)

            view.snp.remakeConstraints({ (maker) in

                maker.leading.trailing.equalToSuperview()
                if let prevView = prevView {
                    maker.top.equalTo(prevView.snp.bottom)
                } else {
                    maker.top.equalToSuperview()
                }
                if lastView {
                    maker.bottom.equalToSuperview()
                }
            })

            prevView = view
        }
    }
}
