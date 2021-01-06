//
//  CitiesListViewController.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 06.01.2021.
//

import Foundation
import UIKit

protocol CitiesListViewControllerDelegate: AnyObject {

    func didSelect(city: CitiesListViewController.City)
}

class CitiesListViewController: UIViewController {

    struct City {

        let id: String
        let name: String

        static var odessa: City {
            return City(id: "698740", name: "Odessa")
        }

        static var amsterdam: City {
            return City(id: "2759794", name: "Amsterdam")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    var cities: [CitiesListViewController.City] = [.odessa, .amsterdam]

    weak var delegate: CitiesListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.reloadData()
    }
}

extension CitiesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].name
        return cell
    }
}

extension CitiesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        delegate?.didSelect(city: cities[indexPath.row])
    }
}
