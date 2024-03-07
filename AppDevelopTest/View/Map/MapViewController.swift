//
//  MapViewController.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/7/24.
//

import Combine
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
        updateMap()
        updateGPSValue()

        postToServer(
            gpsInfo: .init(
                gpsX: String(varGpsX),
                gpsY: String(varGpsY),
                gpsA: String(varGpsA),
                phoneno: varPhoneno
            )
        )
    }

    @objc private func reportButtonTapped() {
        // TODO: 화면 이동 구현
        let viewController = ReportViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - URLSession 관련 메서드
extension MapViewController {

    private func postToServer(gpsInfo: GPSInfo) {
        // URL 설정
        guard let url = URL(string: "https://www.insitestory.com/devTest/mdpert_serverSend.aspx") else {
            print("Invalid URL")
            return
        }

        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            let jsonData = try JSONEncoder().encode(gpsInfo)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // URLSession을 통해 서버 요청
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // 응답 처리
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response status code: \(httpResponse.statusCode)")
                }

                // body 처리
                do {
                    let responseJSON = try JSONDecoder().decode(GPSInfo.self, from: data)
                    print("Response JSON: \(responseJSON)")
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
            task.resume()
        } catch {
            print("Error encoding parameters: \(error)")
            return
        }
    }
}
