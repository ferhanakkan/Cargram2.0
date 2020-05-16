//
//  ToDoDetailViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import RealmSwift

struct ToDoDetailViewModel {
    
    var selectedIndex:Int? = nil
    var delegate:DidToDoChanged?
    var toDoSelectedArray: ToDoRealmModel? = nil
    
    func deleteSelectedPlanFromDatabase() {
        
        let realm = try! Realm()
         let res = realm.objects(ToDoRealmModel.self)[selectedIndex!] 
            do {
                try realm.write{
                    realm.delete(res)
                    self.delegate?.toDoChanged()
                }
            } catch {
                print("Error saving done status, \(error)")
            }
    }
    
    func completeSelectedPlanFromDatabase() {
        let realm = try! Realm()
         let res = realm.objects(ToDoRealmModel.self)[selectedIndex!]
            do {
                try realm.write{
                    res.toDoCompletted = !res.toDoCompletted
                    self.delegate?.toDoChanged()
                }
            } catch {
                print("Error saving done status, \(error)")
            }
    }
}

protocol DidToDoChanged {
    func toDoChanged()
}
