//
//  AppDelegate.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import GoogleMaps
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppManager.shared.setReachability()
        firebase(application)
        setKeyboard()
        autoLogIn()
        setLocalePushNotification()
        setGoogleMaps()
        
        if #available(iOS 12.0, *) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.selectRoot()
            self.window?.makeKeyAndVisible()
        }
            
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {        UIApplication.shared.applicationIconBadgeNumber = 0
    }


    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    private func selectRoot() {
        if let rememberMe = UserDefaults.standard.value(forKey: "rememberMe") as? Bool {
            if !rememberMe {
                UserDefaults.standard.setValue(nil, forKey: "profileImage")
                UserDefaults.standard.setValue(nil, forKey: "rememberMe")
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                    LoadingView.hide()
                }
            }
        }
        window?.rootViewController = Tabbar.createTabBarWithNavigationBar()
    }

    private func setKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    private func autoLogIn() {
        
        if let rememberData = UserDefaults.standard.value(forKey: "rememberMe") as? Bool {
            if !rememberData {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
            }
        }
    }
    
    private func setGoogleMaps() {
        GMSServices.provideAPIKey("AIzaSyBuyjzjaSIWSART-mYxcDujXkOa29ZXEmE")
        GMSPlacesClient.provideAPIKey("AIzaSyBuyjzjaSIWSART-mYxcDujXkOa29ZXEmE")
    }
}

