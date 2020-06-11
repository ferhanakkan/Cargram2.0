//
//  FirebaseExploreService.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Firebase

final class FirebaseExploreService {
    
    lazy var exploreArray: [ExploreModel] = []
    lazy var exploreDetailArray: [ExploreDetailModel] = []
    
    
    internal func getExploreTopics(completion: @escaping([ExploreModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("ExploreTopics").addSnapshotListener { (snapshot, error) in
            if error != nil {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPs", message: error!.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.exploreArray.removeAll()
                    var index = 0
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let subTitle = document.get("Subtitle") as? String, let imageUrl = document.get("imageUrl") as? String, let time = document.get("Time") as? Int{
                            
                            let storage = Storage.storage()
                            let gsReference = storage.reference(forURL:imageUrl)
                            
                            
                            gsReference.downloadURL { url, error in
                                if let error = error {
                                    LoadingView.hide()
                                    print(error)
                                } else {
                                    let data = ExploreModel(title: title, subtitle: subTitle, image: url!, time: time)
                                    self.exploreArray.append(data)
                                    if index == snapshot!.documents.count-1 {
                                        self.exploreArray =  self.exploreArray.sorted{ $0.time < $1.time }
                                        completion(self.exploreArray)
                                    }
                                    index += 1
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    internal func getExploreDetails(title:String, completion: @escaping([ExploreDetailModel]) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("ExploreTopics").document(title).collection("Detail").addSnapshotListener { (snapshot, error) in
            if error != nil {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPS", message: error!.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            } else {                if snapshot?.isEmpty != true && snapshot != nil {
                    self.exploreArray.removeAll()
                    var index = 0
                    for document in snapshot!.documents {
                        if let title = document.get("Title") as? String, let imageUrl = document.get("imageUrl") as? String, let time = document.get("Time") as? Int{
                            let storage = Storage.storage()
                            if title != "Video" {
                                let gsReference = storage.reference(forURL:imageUrl)
                                gsReference.downloadURL { url, error in
                                    if let error = error {
                                        LoadingView.hide()
                                        print(error)
                                    } else {
                                        let data = ExploreDetailModel(title: title,imageUrl: url!, time: time)
                                        self.exploreDetailArray.append(data)
                                        if index == snapshot!.documents.count-1 {
                                            self.exploreDetailArray =  self.exploreDetailArray.sorted{ $0.time < $1.time }
                                            completion(self.exploreDetailArray)
                                        }
                                        index += 1
                                    }
                                }
                            }  else {
                                let data = ExploreDetailModel(title: title,imageUrl: URL(string: imageUrl)!, time: time)
                                self.exploreDetailArray.append(data)
                                if index == snapshot!.documents.count-1 {
                                    self.exploreDetailArray =  self.exploreDetailArray.sorted{ $0.time < $1.time }
                                    completion(self.exploreDetailArray)
                                }
                                index += 1
                            }
                        }
                    }
                    LoadingView.hide()
                }
            }
        }
    }
}
