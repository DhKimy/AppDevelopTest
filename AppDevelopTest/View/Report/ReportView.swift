//
//  ReportView.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/8/24.
//

import UIKit
import WebKit

import SnapKit

final class ReportView: UIView {

    let webView = WKWebView()

    override func draw(_ rect: CGRect) {
        addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
