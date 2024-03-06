//
//  MapViewController.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/7/24.
//

import UIKit

final class MapViewController: UIViewController {

    private var mainMapView = MapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
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
