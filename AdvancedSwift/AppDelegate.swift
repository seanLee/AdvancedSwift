//
//  AppDelegate.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/3/31.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white;
        window?.rootViewController = ArraysViewController();
        window?.makeKeyAndVisible();
        return true
    }
}

