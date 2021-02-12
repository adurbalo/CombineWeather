//
//  CitiesListViewController.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 06.01.2021.
//

import Foundation
import UIKit
import Combine

protocol CitiesListViewControllerDelegate: AnyObject {

    func didSelect(city: CitiesListViewController.City)
}

class CitiesListViewController: UIViewController {


    struct City {

        let id: String
        let name: String

        // Mock data
        static var odessa: City {
            return City(id: "698740", name: "Odessa")
        }

        static var amsterdam: City {
            return City(id: "2759794", name: "Amsterdam")
        }

        static var london: City {
            return City(id: "2643743", name: "London")
        }

        static var paris: City {
            return City(id: "2968815", name: "Paris")
        }

        static var berlin: City {
            return City(id: "2950159", name: "Berlin")
        }

        static var nyc: City {
            return City(id: "5128581", name: "New York")
        }

        static var tokyo: City {
            return City(id: "1850147", name: "Tokyo")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    var cities: [CitiesListViewController.City] = [.odessa, .amsterdam, .london, .paris, .berlin, .nyc, .tokyo]

    weak var delegate: CitiesListViewControllerDelegate?
    
    let storageProvider = StorageProvider()
    var dataProvider: CityDataProvider!
    
    var cancellables: Set<AnyCancellable> = []
    
    private lazy var dataSource =  {
        return UITableViewDiffableDataSource<Int, MOCity>(tableView: tableView) { tableView, indexPath, city in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.textLabel?.text = city.name
            return cell
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.dataSource = dataSource
        
        dataProvider = CityDataProvider(storage: storageProvider)
        dataProvider.$snapshot
            .sink { [weak self] snap in
                if let snap = snap {
                    self?.dataSource.apply(snap)
                }
            }.store(in: &cancellables)
    }
    
    func buildDataSource() -> UITableViewDiffableDataSource<Int, MOCity> {
        
        return UITableViewDiffableDataSource<Int, MOCity>(tableView: tableView) { tableView, indexPath, city in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.textLabel?.text = city.name
            return cell
        }
    }
}

extension CitiesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

//        delegate?.didSelect(city: cities[indexPath.row])
        
        //coreData(city: cities[indexPath.row])
    }
}

