//
//  ExploreViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class ExploreViewModel {

    let firebase  = FirebaseExploreService()
    lazy var exploreArray: [ExploreModel] = []
    
    func fetchExploreData(completion: @escaping(Bool) -> Void) {
        firebase.getExploreTopics { (responseArray) in
            self.exploreArray.removeAll()
            self.exploreArray = responseArray
            completion(true)
        }
    }
    
    func setSelectedRow(indexPath: Int) -> ExploreDetailViewController {
        let vc = ExploreDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.exploreDetailViewModel.titleData = exploreArray[indexPath]
        return vc
    }
}
