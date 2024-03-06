//
//  MapView.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/7/24.
//

import MapKit
import UIKit

import SnapKit

final class MapView: UIView {

    let mapView = MKMapView()

    private let phoneNubmerLabel = {
        let label = UILabel()
        label.text = "Phone No:"
        return label
    }()

    let phoneNubmer = {
        let label = UILabel()
        label.text = "\(varPhoneno)"
        return label
    }()

    let phoneNumberStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()

    private let gpsLabel = {
        let label = UILabel()
        label.text = "GPS X: Y: A:"
        return label
    }()

    let gpsValue = {
        let label = UILabel()
        label.text = "\(varGpsX)\n\(varGpsY)\n\(varGpsA)"
        label.numberOfLines = 3
        return label
    }()

    let gpsStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()

    let sendButton = {
        let button = UIButton()
        button.setTitle("SEND", for: .normal)
        button.setBackgroundColor(.orange, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()

    let reportButton = {
        let button = UIButton()
        button.setTitle("REPORT", for: .normal)
        button.setBackgroundColor(.orange, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()

    override func draw(_ rect: CGRect) {
        mapView.delegate = self
        setView()
        setConstraints()
    }

    private func setView() {
        addSubview(mapView)
        addSubview(phoneNumberStack)
        addSubview(gpsStack)
        addSubview(sendButton)
        addSubview(reportButton)

        phoneNumberStack.addArrangedSubview(phoneNubmerLabel)
        phoneNumberStack.addArrangedSubview(phoneNubmer)
        gpsStack.addArrangedSubview(gpsLabel)
        gpsStack.addArrangedSubview(gpsValue)
    }

    private func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }

        phoneNumberStack.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(gpsStack.snp.top).offset(-10)
        }

        gpsStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
        }

        phoneNubmerLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }

        gpsLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }

        sendButton.snp.makeConstraints { make in

            make.leading.bottom.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }

        reportButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
    }
}

// MARK: - MKMapViewDelegate 메서드
extension MapView: MKMapViewDelegate {

    // 원 표시를 위한 메서드 구현
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
            circleRenderer.strokeColor = .blue
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

#Preview {
    MapViewController()
}
