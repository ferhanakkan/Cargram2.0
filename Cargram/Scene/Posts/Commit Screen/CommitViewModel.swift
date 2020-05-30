//
//  CommitViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 21.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

class CommitViewModel {
    
    var commitArray: [CommitModel]?
    var postID: String?
    
    func sendCommit(commit: String, completion: @escaping() -> Void) {
        if !commit.isEmpty {
            var imageUrl: String?
            getProfileImage { (imageUrlResponse) in
                imageUrl = imageUrlResponse
                
                
                let firestoreDatabase = Firestore.firestore()
                let firestorePost = ["sender" : Auth.auth().currentUser!.displayName!, "senderCommit" : commit, "timestamp": Date().timeIntervalSince1970, "imageUrl" : imageUrl] as [String : Any]
                
                firestoreDatabase.collection("Posts").document(self.postID!).collection("Commit").addDocument(data: firestorePost, completion: { (error) in
                    if error != nil {
                        print("err")
                    } else {
                        completion()
                    }
                })
            }
        }
    }
    
    func getProfileImage(completion: @escaping(String) -> Void) {
        let storage = Storage.storage().reference(withPath: "profileImage/\(Auth.auth().currentUser!.displayName!).jpg")
        
        storage.downloadURL { (url, err) in
            if err != nil {
                completion("https://firebasestorage.googleapis.com/v0/b/cargram-c4400.appspot.com/o/profileImage%2Favatar.png?alt=media&token=51c49218-1fea-4216-b997-e075872d2c5a")
            } else {
                let urlString = url!.absoluteString
                completion(urlString)
            }
        }
    }

}
