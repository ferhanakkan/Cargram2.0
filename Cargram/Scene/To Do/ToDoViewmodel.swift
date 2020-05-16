//
//  ToDoViewmodel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import RealmSwift

final class ToDoViewModel {

    lazy var todoArray: [ToDoRealmModel] = []
    
    func setSelectedRow(indexPath: Int) -> ToDoDetailViewController {
        let vc = ToDoDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.toDoDetailViewModel.toDoSelectedArray = todoArray[indexPath]
        vc.toDoDetailViewModel.selectedIndex = indexPath
        return vc
    }
    
    func numberOfRows() -> Int{
        if todoArray.count == 0 {
            return 1
        } else {
            return todoArray.count
        }
    }
    
    func fetchData(completion: @escaping(Bool) -> Void) {
        let realm = try! Realm()
        let res = realm.objects(ToDoRealmModel.self)
        todoArray.removeAll()
        for data in res {
            print(data)
            self.todoArray.append(data)
        }
        completion(true)
    }
    
    func setCollectionViewCell(owner: ToDoViewController, indexPath: IndexPath) -> UICollectionViewCell {
        
        switch todoArray.count {
        case 0:
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoNonCollectionViewCell", for: indexPath) as! ToDoNonCollectionViewCell
            return cell
        default:
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCollectionViewCell", for: indexPath) as! ToDoCollectionViewCell
            if todoArray[indexPath.row].picArray.count != 0 {
                cell.image.image = UIImage(data: todoArray[indexPath.row].picArray[0])
            } else {
                cell.backgroundColor = .gray
            }
            cell.isCompletedImage.isHidden = !(todoArray[indexPath.row].toDoCompletted)
            cell.title.text = todoArray[indexPath.row].toDoTitle
            cell.subTitle.text = todoArray[indexPath.row].toDoDescription
            return cell
        }
    }
}
