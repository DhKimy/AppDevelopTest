//
//  MapViewController.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/7/24.
//

import MapKit
import UIKit

final class MapViewController: UIViewController {

    private var mainMapView = MapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        initialMapSetting()
    }
}

// MARK: - MapView UI 관련
extension MapViewController {

    private func setView() {
        view.addSubview(mainMapView)
        mainMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - mapView 기능 관련
extension MapViewController {

    private func initialMapSetting() {
        setMarker()
        setMapScale()
    }

    // 마커 세팅
    private func setMarker() {
        let coordinate = CLLocationCoordinate2D(latitude: varGpsX, longitude: varGpsY)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "현재 위치"
        mainMapView.mapView.addAnnotation(annotation)

        // 정확도 반경 원 추가
        let circle = MKCircle(center: coordinate, radius: varGpsA)
        mainMapView.mapView.addOverlay(circle)
    }

    // 지도 축척 설정
    private func setMapScale() {
        let regionRadius: CLLocationDistance = 250
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: varGpsX, longitude: varGpsY),
            latitudinalMeters: regionRadius, 
            longitudinalMeters: regionRadius
        )
        mainMapView.mapView.setRegion(region, animated: true)
    }
}
