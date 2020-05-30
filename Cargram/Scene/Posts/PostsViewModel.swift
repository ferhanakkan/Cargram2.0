//
//  PostsViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 19.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import PromiseKit

class FlowViewModel {
    
    weak var delegate:FetchingDidEnd?
    var fetchingMore = false
    var endReached = false
    var firebase = FirebasePostService()
    var postData: [PostModel] = []
    
    
    func scrollDidEnd() {
        if !fetchingMore && !endReached {
            beginBatchFetch()
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        firstly {
            firebase.fetchPosts(fetchingMore: fetchingMore, postData: postData)
        }.done { [unowned self] newDatas in
            for data in newDatas {
                self.postData.append(data)
            }
            self.endReached = newDatas.count == 0
            self.delegate?.fetchDidEnd()
        }.ensure {
            LoadingView.hide()
            self.fetchingMore = false
        }.catch { (err) in
            AppManager.shared.messagePresent(title: "OOPSS", message: err.localizedDescription, type: .error, isInternet: .nonInternetAlert)
        }
    }
    
    func refreshControl(completion: @escaping(()) -> Void) {
        fetchingMore = false
        endReached = false
        postData.removeAll()
        completion(())
        beginBatchFetch()
    }
}

protocol FetchingDidEnd: AnyObject {
    func fetchDidEnd()
}
