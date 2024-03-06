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
        locationManager.stopUpdatingLocation() // 한 번만 정보를 업데이트 하기 위함
        guard let location = locations.first else { return }
        varGpsX = location.coordinate.latitude
        varGpsY = location.coordinate.longitude
        varGpsA = location.verticalAccuracy
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation() // 외부에서 이 메서드로 한 번 정보 갱신을 요청할 수 있음
    }
}

