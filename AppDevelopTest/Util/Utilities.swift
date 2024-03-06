//
//  Utilities.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/6/24.
//

import CoreLocation
import UIKit

final class GPSManager: NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        varGpsX = location.coordinate.latitude
        varGpsY = location.coordinate.longitude
        varGpsA = location.verticalAccuracy
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

