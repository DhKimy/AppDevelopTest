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
    private let gpsManager = GPSManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        addButtonTarget()
        updateMap()
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

    private func updateGPSValue() {
        mainMapView.gpsValue.text = "\(varGpsX)\n\(varGpsY)\n\(varGpsA)"
    }
}

// MARK: - mapView 기능 관련
extension MapViewController {

    private func updateMap() {
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

// MARK: - Button 관련 메서드
extension MapViewController {

    private func addButtonTarget() {
        mainMapView.sendButton.addTarget(
            self,
            action: #selector(sendButtonTapped),
            for: .touchUpInside
        )

        mainMapView.reportButton.addTarget(
            self,
            action: #selector(reportButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func sendButtonTapped() {
        gpsManager.startUpdatingLocation()

        // TODO: 텍스트, Map 업데이트
        updateMap()
        updateGPSValue()

        // TODO: Post 구현
    }

    @objc private func reportButtonTapped() {
        // TODO: 화면 이동 구현
    }
}
