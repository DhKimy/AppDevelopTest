//
//  IntroViewController.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/6/24.
//

import UIKit

final class IntroViewController: UIViewController {

    var gpsManager: GPSManager = GPSManager()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
}

// MARK: - 서버 체크 페이지 호출 관련
extension IntroViewController {

    /// 서버 체크 페이지 호출
    private func getServerCheckPage() {

    }
}

// MARK: - WebView 관련
extension IntroViewController {
    
}

