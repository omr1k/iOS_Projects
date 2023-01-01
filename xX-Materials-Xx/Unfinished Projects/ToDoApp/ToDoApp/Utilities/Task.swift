//
//  Task.swift
//  ToDoApp
//
//  Created by Omar Khattab on 07/12/2022.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    
    // DB Vars
    @Persisted(primaryKey: true) var id: ObjectId  // Realm id generator "same as UUID"
    @Persisted var title = ""
    @Persisted var completed = false
}
