//
//  ViewController.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 17.12.2020.
//

import UIKit
import Combine
import CombineCocoa

class ViewController: UIViewController {

    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!

    var weatherFetcher = CurrentWeatherFetcher()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //loadData()

        setupBindings()
    }

    func setupBindings() {

        queryTextField
            .textPublisher
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .replaceNil(with: "")
            .filter { !$0.isEmpty }
            .sink {
                self.resultTextView.text = $0
                self.loadData(for: $0)
            }.store(in: &cancellables)
    }

    func loadData(for city: String) {

        weatherFetcher.receiveWeather(for: city).sink { (completion) in

            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }

        } receiveValue: { data in

//            let string = String.init(data: data, encoding: .utf8) ?? "NO DATA"
            print(data.name)
        }.store(in: &cancellables)
    }

}

