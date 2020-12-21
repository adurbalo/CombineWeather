//
//  UIStoryboard+Extensions.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 21.12.2020.
//

import Foundation
import UIKit

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>() -> T {

        let vc = self.instantiateViewController(identifier: String(describing: T.self)) as! T
        return vc
    }
}
