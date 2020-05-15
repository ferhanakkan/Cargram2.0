//
//  NewTopicViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

final class NewTopicViewModel {
    
    let firebase = FirebaseForumService()
    
    func createTopic(title: String, subTitle: String, check: Bool) {
        if title != "" && subTitle != "" {
            firebase.createTopicTitle(title: title, subtitle: subTitle, usernameController: check) { (_) in
                UIApplication.getPresentedViewController()?.dismiss(animated: true, completion: nil)
            }
        } else {
            errorAlert()
        }
    }
    
    func errorAlert() {
        AppManager.shared.messagePresent(title: "OOPS", message: "Please chech title and subtitle can't be empty", type: .error, isInternet: .nonInternetAlert)
    }
}
