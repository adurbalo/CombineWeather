//
//  UIViewController+Extensions.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {

    func add<T: UIViewController>(childVC: T, toView: UIView) {

        self.addChild(childVC)
        toView.addSubview(childVC.view)

        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        childVC.view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        childVC.didMove(toParent: self)
    }

    func remove<T: UIViewController>(childVC: T) {

        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }

    func append<T: UIViewController>(childVC: T, toView: UIView) {

        addChild(childVC)
        toView.appendAsBottomSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
}
