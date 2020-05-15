//
//  FirebaseUserService.swift
//  Cargram
//
//  Created by Ferhan Akkan on 12.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseUserService {
 
    func resetPassword(email: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOOPS", message: error.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            } else {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "Success", message: "Reset Password Succesful, check your mailbox.", type: .success, isInternet: .nonInternetAlert)
                completion(true)
            }
        }
    }
    
    func logIn(email: String , password: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOOOPS", message: error.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            } else {
                LoadingView.hide()
                completion(false)
            }
        }
    }
    
    func createUser(email: String , password: String, username: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                AppManager.shared.messagePresent(title: "OOOOPS", message: error.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            } else {
                self.setUsername(username: username) { (_) in
                    completion(true)
                }
            }
        }
    }
    
     func setUsername(username: String, completion: @escaping(Bool) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { (error) in
            LoadingView.hide()
            completion(true)
        }
    }
    
     func signOut() {
        UserDefaults.standard.setValue(nil, forKey: "profileImage")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            LoadingView.hide()
        }
        LoadingView.hide()
        UIApplication.getPresentedViewController()?.view.window?.rootViewController = Tabbar.createTabBarWithNavigationBar()
    }
    
}
