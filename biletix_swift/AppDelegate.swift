//
//  AppDelegate.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 08.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let searchVC = SearchFormBuilder().build()
        let rootNC = UINavigationController(rootViewController: searchVC)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        return true
    }

}

