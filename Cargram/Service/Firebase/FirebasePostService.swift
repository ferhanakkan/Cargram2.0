//
//  FirebasePostService.swift
//  Cargram
//
//  Created by Ferhan Akkan on 20.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Firebase
import PromiseKit

//MARK: - Post Actions

final class FirebasePostService {
    
    func postImage(data: Data) -> Promise<URL> {
        let (promise, seal) = Promise<URL>.pending()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("PostImages")
        let uuid = UUID().uuidString
        let imageRef = mediaFolder.child("\(uuid).jpeg")
        
        imageRef.putData(data, metadata: nil) { (metadata, error) in
            if error != nil {
                seal.reject(error!)
            } else {
                imageRef.downloadURL { (url, error) in
                    if error == nil {
                        return seal.fulfill(url!)
                    }
                }
            }
        }
        return promise
    }
    
    internal func getUserImageUrl(imageUrl: URL) -> Promise<[String]> {
        let (promise, seal) = Promise<[String]>.pending()
        let storage = Storage.storage().reference(withPath: "profileImage/\(Auth.auth().currentUser!.displayName!).jpg")
        
        storage.downloadURL { (url, err) in
            let imageString = imageUrl.absoluteString
            if err != nil {
                seal.fulfill([imageString, "https://firebasestorage.googleapis.com/v0/b/cargram-c4400.appspot.com/o/profileImage%2Favatar.png?alt=media&token=51c49218-1fea-4216-b997-e075872d2c5a"])
            } else {
                let urlString = url!.absoluteString
                seal.fulfill([imageString, urlString])
            }
        }
        return promise
    }
    
    
    func postDatas(commit: String, postUrl:String, profileImageUrl: String) -> Promise<Void> {
        let (promise, seal) = Promise<Void>.pending()
        let firestoreDatabase = Firestore.firestore()
        let imageUrl = postUrl
        let firestorePost = ["imageUrl" : imageUrl , "sender" : Auth.auth().currentUser!.displayName!, "senderCommit" : commit, "timestamp": Date().timeIntervalSince1970, "like": 0, "senderProfileImage" : profileImageUrl] as [String : Any]
        
        firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
            if error != nil {
                seal.reject(error!)
            } else {
                return seal.fulfill(())
            }
            
        })
        return promise
    }
    
    func postCommit(commit: String, postId: String, imageUrl: String) -> Promise<Void> {
        let (promise, seal) = Promise<Void>.pending()
        let firestoreDatabase = Firestore.firestore()
        let firestorePost = ["sender" : Auth.auth().currentUser!.displayName!, "senderCommit" : commit, "timestamp": Date().timeIntervalSince1970, "imageUrl" : imageUrl] as [String : Any]
        
        firestoreDatabase.collection("Posts").document(postId).collection("Commit").addDocument(data: firestorePost, completion: { (error) in
            if error != nil {
                seal.reject(error!)
            } else {
                return seal.fulfill(())
            }
            
        })
        return promise
    }
    
    func postLike(postId: String, imageUrl: String) -> Promise<Void> {
        let (promise, seal) = Promise<Void>.pending()
        let firestoreDatabase = Firestore.firestore()
        let firestorePost = ["sender" : Auth.auth().currentUser!.displayName!, "timestamp": Date().timeIntervalSince1970 , "imageUrl" : imageUrl] as [String : Any]
        
        firestoreDatabase.collection("Posts").document(postId).collection("Like").addDocument(data: firestorePost, completion: { (error) in
            if error != nil {
                seal.reject(error!)
            } else {
                return seal.fulfill(())
            }
        })
        return promise
    }
}

//MARK: - Get Actions

extension FirebasePostService {
    
    func fetchPosts(fetchingMore: Bool, postData: [PostModel]) -> Promise<[PostModel]> {
        let (promise,seal) = Promise<[PostModel]>.pending()
        let firestoreDatabase = Firestore.firestore()
        let lastPost = postData.last
        let query: Query
        if lastPost == nil {
            query = firestoreDatabase.collection("Posts").order(by: "timestamp",descending: true).limit(to: 10)
        } else {
            query = firestoreDatabase.collection("Posts").order(by: "timestamp",descending: true).start(after: [lastPost!.date]).limit(to: 10)
        }

        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                seal.reject(err)
            } else {
                var post: [PostModel] = []
                for document in querySnapshot!.documents {
                    let documentID = document.documentID

                    if let commit = document.get("senderCommit") as? String, let date = document.get("timestamp") as? Double, let imageUrl = document.get("imageUrl") as? String, let like = document.get("like") as? Int, let username = document.get("sender") as? String , let senderProfileImage = document.get("senderProfileImage") as? String{
                        let newPost = PostModel(commit: commit, date: date, imageUrl: imageUrl, like: like, username: username, documentID: documentID, senderProfileImage: senderProfileImage)
                        post.append(newPost)
                    }
                }
                return seal.fulfill(post)
            }
        }
        return promise
    }
    

    
    func fetchLikes(postID: String) -> Promise<[LikeModel]> {
        let (promise,seal) = Promise<[LikeModel]>.pending()
        let firestoreDatabase = Firestore.firestore()
        let query = firestoreDatabase.collection("Posts").document(postID).collection("Like").order(by: "timestamp",descending: true)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                seal.reject(err)
            } else {
                var post: [LikeModel] = []
                for document in querySnapshot!.documents {
                    let documentID = document.documentID
                    
                    if let imageUrl = document.get("imageUrl") as? String, let sender = document.get("sender") as? String, let date = document.get("timestamp") as? Double {
                        let newPost = LikeModel(sender: sender, imageUrl: imageUrl, timestamp: date, likeID: documentID, postID: postID)
                        post.append(newPost)
                    }
                }
                return seal.fulfill(post)
            }
        }
        return promise
    }
    
    func fetchCommit(postID: String) -> Promise<[CommitModel]> {
        let (promise,seal) = Promise<[CommitModel]>.pending()
        let firestoreDatabase = Firestore.firestore()
        let query = firestoreDatabase.collection("Posts").document(postID).collection("Commit").order(by: "timestamp",descending: true)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                seal.reject(err)
            } else {
                var post: [CommitModel] = []
                for document in querySnapshot!.documents {
                    let documentID = document.documentID
                    
                    if let imageUrl = document.get("imageUrl") as? String, let sender = document.get("sender") as? String, let commit = document.get("senderCommit") as? String, let date = document.get("timestamp") as? Double {
                        let newPost = CommitModel(sender: sender, imageUrl: imageUrl, timestamp: date, commit: commit, commitID: documentID, postID: postID)
                        post.append(newPost)
                    }
                }
                return seal.fulfill(post)
            }
        }
        return promise
    }
    
}


//MARK: - Delete Actions

extension FirebasePostService {
    
    func deletePost(postId: String)-> Promise<Void> {
        let (promise,seal) = Promise<Void>.pending()
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").document(postId).delete() { err in
            if let err = err {
                seal.reject(err)
            } else {
                return seal.fulfill(())
            }
        }
        return promise
    }
    
    func deleteLike(postId: String, likeId: String) -> Promise<Void> {
        let (promise,seal) = Promise<Void>.pending()
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").document(postId).collection("Like").document(likeId).delete() { err in
            if let err = err {
                seal.reject(err)
            } else {
                return seal.fulfill(())
            }
        }
        return promise
    }
    
    func deleteCommit(postId: String, commitId: String) -> Promise<Void> {
        let (promise,seal) = Promise<Void>.pending()
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").document(postId).collection("Commit").document(commitId).delete() { err in
            if let err = err {
                seal.reject(err)
            } else {
                return seal.fulfill(())
            }
        }
        return promise
    }
    
}
