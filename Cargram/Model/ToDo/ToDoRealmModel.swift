//
//  ToDoRealmModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 16.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import RealmSwift

class ToDoRealmModel: Object {
    @objc dynamic var toDoTitle: String?
    @objc dynamic var toDoDescription: String?
    @objc dynamic var toDoCompletted = false
    let picArray = List<Data>()
    @objc dynamic var deathline: String?
}
