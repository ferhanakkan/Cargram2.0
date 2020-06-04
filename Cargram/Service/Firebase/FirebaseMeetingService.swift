//
//  FirebaseMeetingService.swift
//  Cargram
//
//  Created by Ferhan Akkan on 3.06.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Firebase

class FirebaseMeetingService {
    
    func getEventDatas(completion: @escaping([EventModel]?,Error?) -> Void) {
       
        let firestoreDatabase = Firestore.firestore()
        let query = firestoreDatabase.collection("Events").order(by: "timestamp",descending: true)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(nil,err)
            } else {
                var event: [EventModel] = []
                for document in querySnapshot!.documents {
                    let documentID = document.documentID
                    
                    if let title = document.get("title") as? String , let description = document.get("description") as? String, let address = document.get("address") as? String , let timestamp = document.get("timestamp") as? Double , let longitude = document.get("longitude") as? Double , let latitude = document.get("latitude") as? Double, let creator = document.get("creator") as? String{
                        let newPost = EventModel(latitude: latitude, longitude: longitude, timestamp: timestamp, title: title, Address: address, documentID: documentID, creator: creator, description: description)
                        event.append(newPost)
                    }
                }
              completion(event,nil)
            }
        }
    }
    
    func createEvent(title: String, description: String, address: String, timestamp: Double, latitude: Double, longitude: Double, completion: @escaping() ->Void) {
        let firestoreDatabase = Firestore.firestore()
        
        let firestorePost = ["title" : title , "description" : description, "address" : address, "timestamp": timestamp, "latitude": latitude , "longitude" : longitude, "creator" : Auth.auth().currentUser!.displayName!] as [String : Any]
        
        firestoreDatabase.collection("Events").addDocument(data: firestorePost, completion: { (error) in
            if error != nil {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPS", message: error!.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            } else {
                completion()
            }
            
        })
    }
}
