//
//  IntroViewController.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/6/24.
//

import Combine
import UIKit
import WebKit

import SnapKit

final class IntroViewController: UIViewController {

    private var subscriptions = Set<AnyCancellable>()
    private var introView = IntroView()
    private var sec: Int?
    private var gpsManager: GPSManager = GPSManager()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        introView.webView.navigationDelegate = self
        getServerCheckPage()
        setView()
    }
}

// MARK: - 서버 체크 페이지 호출 관련
extension IntroViewController {

    /// 서버 체크 페이지 호출
    private func getServerCheckPage() {
        guard let url = URL(string: "https://www.insitestory.com/devTest/mdpert_serverCheck.aspx?phoneno=\(varPhoneno)") else {
            print("유효하지 않은 URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Intro.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("실패")
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                print("response: ", response)
                guard let self = self else { return }
                self.showWebView(
                    introPageURL: URL(string: response.intropage) ?? URL(string: "https://www.insitestory.com")!
                )
                self.sec = Int(response.sec) ?? 3
            }
            .store(in: &subscriptions)
    }

    /// 웹 뷰를 표시하고 일정 시간 후 EmptyView로 전환
    private func showWebView(introPageURL: URL) {
        DispatchQueue.main.async {
            self.introView.webView.load(URLRequest(url: introPageURL))
        }
    }
}

// MARK: - WebView 관련
extension IntroViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 웹 페이지 로드가 완료된 후 지연 작업 예약
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(sec ?? 3)) {
            self.changeMapVC()
        }
    }
}

// MARK: - IntroView 관련
extension IntroViewController {

    /// IntroView의 기본 UI 세팅
    private func setView() {
        view.addSubview(introView)
        introView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    /// 지도맵 화면으로 이동하는 로직
    private func changeMapVC() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

        // 이전 IntroViewController 해제
        if let previousViewController = window.rootViewController as? IntroViewController {
            previousViewController.dismiss(animated: false, completion: nil)
        }

        let nextViewController = MapViewController()
        window.rootViewController = nextViewController
    }
}
