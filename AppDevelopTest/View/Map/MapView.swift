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
        return stack
    }()

    private let gpsLabel = {
        let label = UILabel()
        label.text = "GPS X: Y: A:"
        return label
    }()

    let gpsValue = {
        let label = UILabel()
        label.text = "\(varGpsX), \(varGpsY), \(varGpsA)"
        return label
    }()

    let gpsStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
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
            make.height.equalTo(300)
        }

        phoneNumberStack.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(gpsStack.snp.top).offset(-10)
        }

        gpsStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
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

#Preview {
    MapViewController()
}
