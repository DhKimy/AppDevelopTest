//
//  ReportViewController.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/8/24.
//

import UIKit

final class ReportViewController: UIViewController {

    private var reportView = ReportView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        showReportPage()
    }
}

// MARK: - webview 관련
extension ReportViewController {

    /// IntroView의 기본 UI 세팅
    private func setView() {
        view.addSubview(reportView)
        reportView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    /// 리포트 페이지 호출
    private func showReportPage() {
        guard let url = URL(string: "https://www.insitestory.com/devTest/mdpert_serverReport.aspx?phoneno=\(varPhoneno)") else {
            print("유효하지 않은 URL")
            return
        }

        self.reportView.webView.load(URLRequest(url: url))
    }
}
