//
//  LocationService.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 18.12.2020.
//

import Foundation
import Combine
import CoreLocation

protocol LocationCombinable {

    func authorizationPublisher() -> AnyPublisher<CLAuthorizationStatus, Never>
    func locationPublisher() -> AnyPublisher<CLLocation, Never>
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

class LocationService: NSObject {

    let authorizationSubject = PassthroughSubject<CLAuthorizationStatus, Never>()
    let locationSubject = PassthroughSubject<CLLocation, Never>()

    let locationManager = CLLocationManager()

    override init() {
        super.init()

        locationManager.delegate = self
    }
}

extension LocationService: LocationCombinable {

    func startUpdatingLocation() {

        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {

        locationManager.stopUpdatingLocation()
    }

    func authorizationPublisher() -> AnyPublisher<CLAuthorizationStatus, Never> {

        return authorizationSubject.eraseToAnyPublisher()

//        return Just(locationManager.authorizationStatus)
//            .merge(with: authorizationSubject.compactMap { $0 }
//            ).eraseToAnyPublisher()
    }

    func locationPublisher() -> AnyPublisher<CLLocation, Never> {

        return locationSubject.eraseToAnyPublisher()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let lastLocation = locations.first else {
            return
        }
        locationSubject.send(lastLocation)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        authorizationSubject.send(manager.authorizationStatus)
    }
}
