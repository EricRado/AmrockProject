//
//  WebViewController.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/13/20.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {

	private let url: URL

	private lazy var webView: WKWebView = {
		let webView = WKWebView()
		webView.translatesAutoresizingMaskIntoConstraints = false
		webView.uiDelegate = self
		webView.allowsBackForwardNavigationGestures = true
		return webView
	}()

	init(title: String, url: URL) {
		self.url = url
		super.init(nibName: nil, bundle: nil)
		navigationItem.title = title
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

	private func setupUI() {
		view.backgroundColor = .white

		let backBarButtonItem = UIBarButtonItem(
			title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
		let nextBarButtonItem = UIBarButtonItem(
			title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
		toolbarItems = [backBarButtonItem, nextBarButtonItem]
		navigationController?.setToolbarHidden(false, animated: true)
		webView.load(URLRequest(url: url))

		view.addSubview(webView)
		NSLayoutConstraint.activate([
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	@objc private func backButtonTapped() {
		if webView.canGoBack {
			webView.goBack()
		}
	}

	@objc private func nextButtonTapped() {
		if webView.canGoForward {
			webView.goForward()
		}
	}

}
