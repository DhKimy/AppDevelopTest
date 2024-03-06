//
//  IntroViewController.swift
//  AppDevelopTest
//
//  Created by 김동현 on 3/6/24.
//

import Combine
import UIKit
import WebKit

final class IntroViewController: UIViewController {

    var gpsManager: GPSManager = GPSManager()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gpsManager.stopUpdatingLocation()
        getServerCheckPage()
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
                    introPageURL: URL(string: response.intropage) ?? URL(string: "https://www.insitestory.com")!,
                    sec: Int(response.sec) ?? 3
                )
            }
            .store(in: &subscriptions)
    }

    /// 웹 뷰를 표시하고 일정 시간 후 EmptyView로 전환
    private func showWebView(introPageURL: URL, sec: Int) {
        DispatchQueue.main.async {
            let webView = WKWebView()
            webView.load(URLRequest(url: introPageURL))
            self.view.addSubview(webView)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(sec)) {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

            // 이전 IntroViewController 해제
            if let previousViewController = window.rootViewController as? IntroViewController {
                previousViewController.dismiss(animated: false, completion: nil)
            }

            let emptyViewController = UIViewController()
            window.rootViewController = emptyViewController
        }
    }
}
