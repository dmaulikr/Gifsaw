//
//  AppDelegate.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-04.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().tintColor = .groupTableViewBackground
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.groupTableViewBackground]
        
        let viewController  = ViewController()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}
