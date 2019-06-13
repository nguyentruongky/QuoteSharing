//
//  AppDelegate.swift
//  Storex
//
//  Created by Ky Nguyen on 4/2/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setupApp()
        return true
    }

    func setupApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller: UIViewController
        if Auth.auth().currentUser == nil {
            controller = wrap(LoginController())
        } else {
            controller = Boss()
            GetMyDetailWorker().execute()
        }
        window!.rootViewController = controller
        window!.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }
    
    @objc func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

