//
//  Prospect.swift
//  HotProspects
//
//  Created by Omar Khattab on 16/10/2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    var date = Date()
}


@MainActor class Prospects: ObservableObject {
    
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")

    init() {
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            people = try decoder.decode([Prospect].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            people = []
        }

    }
    
    private func save() {
        do {
            print("save Path====>\(jsonFilePath.path)")
            let data = try JSONEncoder().encode(people)
            try data.write(to: jsonFilePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    func remove(index: Int) {
        
        print("perople \(people.count)")
        let elemntPostion = (people.count - index)-1
        print("elment postion \(elemntPostion)")
        people.remove(at: elemntPostion)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}





//=====Loading form user default=====
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//===================================


//===Save to user defaults=====
//if let encoded = try? JSONEncoder().encode(people) {
//    UserDefaults.standard.set(encoded, forKey: saveKey)
//}
//=============================
