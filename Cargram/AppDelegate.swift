//
//  AppDelegate.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppManager.shared.setReachability()
        firebase(application)
        setKeyboard()
        
        if #available(iOS 12.0, *) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.selectRoot()
            self.window?.makeKeyAndVisible()
        }
            
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func selectRoot() {
     /*   let currentUser = Auth.auth().currentUser
        if let rememberMe = UserDefaults.standard.value(forKey: "rememberMe") as? Bool {
            if currentUser != nil && rememberMe {
                window?.rootViewController = Tabbar.createTabBarWithNavigationBar(owner: self)
            } else {
                window?.rootViewController = NavigationBar.createNavigatonController(owner: self)
            }
            
        } else {
            window?.rootViewController = NavigationBar.createNavigatonController(owner: self)
        }*/
        
        window?.rootViewController = Tabbar.createTabBarWithNavigationBar()
    }

    private func setKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

