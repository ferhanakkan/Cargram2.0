//
//  CategoryTopicsViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class CategoryTopicsViewModel {
    
    let firebase = FirebaseForumService()
    lazy var topicsModel: [TopicsModel] = []
    
    func getSelectedTopicDatas(completion: @escaping(Bool) -> Void) {
        firebase.getTopics { (response) in
            self.topicsModel.removeAll()
            self.topicsModel = response
            completion(true)
        }
    }
    
    func setSelectedCategory(indexPath: Int) {
//        AppManager.shared.selectedForumCategory = topicsModel[indexPath].title
//
//        UIApplication.getPresentedViewController()?.navigationController?.show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
    }
}
