//
//  AppDelegate.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	private static let dateResignedKey = "DateTimeRessigned"
	private static let dismissalTimeLimit = 60.0

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = LoginViewController()
		window?.makeKeyAndVisible()
		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		UserDefaults().setValue(nil, forKey: AppDelegate.dateResignedKey)
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		guard let dateResigned = UserDefaults().value(forKey: AppDelegate.dateResignedKey) as? Date else { return }
		if Date().timeIntervalSince(dateResigned) > AppDelegate.dismissalTimeLimit {
			window?.rootViewController = LoginViewController()
		}
	}

	func applicationWillResignActive(_ application: UIApplication) {
		UserDefaults().setValue(Date(), forKey: AppDelegate.dateResignedKey)
	}

}
