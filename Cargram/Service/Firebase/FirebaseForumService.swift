//
//  FirebaseForumService.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

final class FirebaseForumService {
    
    lazy var topicsArray: [TopicsModel] = []
    lazy var messageArray: [MessageModel] = []
    var delegate:MessageDidArrived? = nil
    
    internal func getOtherUsersImage(username: String, completion: @escaping(Data) -> Void) {
        let storage = Storage.storage().reference(withPath: "profileImage/\(username).jpg")
        
        storage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPS", message: error.localizedDescription , type: .error, isInternet: .nonInternetAlert)
            } else {
                LoadingView.hide()
                completion(data!)
            }
        }
    }
    
    internal func getTopics(completion: @escaping([TopicsModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Topics").document("Data").collection(AppManager.shared.selectedForumCategory).addSnapshotListener { (snapshot, error) in
            if error != nil {
                AppManager.shared.messagePresent(title: "OOPS", message: error!.localizedDescription , type: .error, isInternet: .nonInternetAlert)
                LoadingView.hide()
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.topicsArray.removeAll()
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let subTitle = document.get("Subtitle") as? String{
                            let data = TopicsModel(title: title, subTitle: subTitle)
                            self.topicsArray.append(data)
                        }
                    }
                    DispatchQueue.main.async {
                        LoadingView.hide()
                        completion(self.topicsArray)
                    }
                }
            }
        }
    }
    
    internal func createTopicTitle(title: String, subtitle: String, usernameController:Bool, completion: @escaping(Bool) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        var username = ""
        if usernameController {
            username = (Auth.auth().currentUser?.displayName)!
        } else {
            username = "Anonymous"
        }
        let docData: [String: Any] = [
            "Username": username,
            "Title": title,
            "Subtitle": subtitle,
            "Time": Date().timeIntervalSince1970
        ]
        fireStoreDatabase.collection("TopicDatas").document("Data").collection(AppManager.shared.selectedForumCategory).document(title).collection("Message").addDocument(data: docData) { err in
            if let err = err {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPS", message: err.localizedDescription , type: .error, isInternet: .nonInternetAlert)
            }
        }
        fireStoreDatabase.collection("Topics").document("Data").collection(AppManager.shared.selectedForumCategory).document(title).setData(docData) { err in
            if let err = err {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPS", message: err.localizedDescription , type: .error, isInternet: .nonInternetAlert)
            } else {
                DispatchQueue.main.async {
                    LoadingView.hide()
                    completion(true)
                }
            }
        }
        
    }
    
    internal func getSelectedTopicMessage(completion: @escaping([MessageModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("TopicDatas").document("Data").collection(AppManager.shared.selectedForumCategory).document(AppManager.shared.selectedForumTopic).collection("Message").order(by: "Time").addSnapshotListener { (snapshot, error) in
            if error != nil {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPS", message: error!.localizedDescription , type: .error, isInternet: .nonInternetAlert)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.messageArray.removeAll()
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let username = document.get("Username") as? String, let subtitle = document.get("Subtitle") as? String{
                            let data = MessageModel(title: title,subtitle: subtitle, username: username)
                            self.messageArray.append(data)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(self.messageArray)
                        self.delegate?.messageFetched()
                        LoadingView.hide()
                        if !self.messageArray.isEmpty {
                            self.delegate?.scrollToLastMessage(toRow: self.messageArray.count-1)
                           
                        }
                    }
                }
            }
        }
    }
    
    internal func sendMessageToTopic(message: String) {
        let fireStoreDatabase = Firestore.firestore()
        let docData: [String: Any] = [
            "Username": Auth.auth().currentUser?.displayName,
            "Title": message,
            "Subtitle": "",
            "Time": Date().timeIntervalSince1970
        ]
        fireStoreDatabase.collection("TopicDatas").document("Data").collection(AppManager.shared.selectedForumCategory).document(AppManager.shared.selectedForumTopic).collection("Message").addDocument(data: docData) { err in
            if let err = err {
                AppManager.shared.messagePresent(title: "OOPS", message: err.localizedDescription , type: .error, isInternet: .nonInternetAlert)
            } else {
                print("Document successfully written!")
            }
        }
    }
    
}

protocol MessageDidArrived {
    func messageFetched()
    func scrollToLastMessage(toRow: Int)
}
