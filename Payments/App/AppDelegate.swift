//
//  AppDelegate.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        appCordinator = AppCoordinator(window: window)
        appCordinator?.start()
        return true
    }
}
