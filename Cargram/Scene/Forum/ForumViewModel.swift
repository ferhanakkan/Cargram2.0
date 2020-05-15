//
//  ForumViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

final class ForumViewModel {
    
    let categoriesName = ["Engine", "Brake", "Sound"]

    func setSelectedCategory(indexPath: Int) {
        AppManager.shared.selectedForumCategory = categoriesName[indexPath]
    }


}
