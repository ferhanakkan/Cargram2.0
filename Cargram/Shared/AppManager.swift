//
//  AppManager.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

struct AppManager {
    
    static var shared = AppManager()
    
    let reachability: Reachability = try! Reachability(hostname: "google.com")

    func setReachability() {
        do {
            try reachability.startNotifier()
        } catch {
            assertionFailure("Unable to start\nnotifier")
        }

       reachability.whenUnreachable = { reachability in
            let alert = UIAlertController(title: "Your internet connection has been lost!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { action in
                if self.reachability.connection == .unavailable {
                    UIApplication.getPresentedViewController()!.present(alert, animated: true, completion: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { action in
                exit(0)
            }))
            UIApplication.getPresentedViewController()!.present(alert, animated: true, completion: nil)
        }
    }
    
    func messagePresent(title: String, message: String, type: ImageType, isInternet: InternetAlert) {
        let vc = AlertView()
        vc.titleLabel.text = title
        vc.messagelabel.text = message
        vc.imageTypeSelector = type
        vc.internetConnectionButtonSelector = isInternet
        UIApplication.getPresentedViewController()!.present(vc, animated: true)
    }
}