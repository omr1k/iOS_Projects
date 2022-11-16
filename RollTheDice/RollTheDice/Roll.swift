//
//  Roll.swift
//  RollTheDice
//
//  Created by Omar Khattab on 16/11/2022.
//


import Foundation

struct Roll: Codable, Identifiable {
    var id = UUID()
    let numberOfDices : Int
    let diceSize : Int
    let diceResult : [Int]
    let total : Int
    
//    static let example = Roll(diceSize: "10", diceResult: ["4"])
    static let example = Roll(numberOfDices: 5, diceSize: 10, diceResult: [4], total: 5)

}

@MainActor class Rolles: ObservableObject {
    @Published private(set) var rolles: [Roll]
    let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedRolles")
    
    init() {
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            rolles = try decoder.decode([Roll].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            rolles = [].reversed()
        }
    }
    
    private func save() {
            do {
                print("save Path====>\(jsonFilePath.path)")
                let data = try JSONEncoder().encode(rolles)
                try data.write(to: jsonFilePath, options: [.atomic, .completeFileProtection])
                print(jsonFilePath)
            } catch {
                print("Unable to save data.")
            }
        }
        
        func add(_ roll: Roll) {
            rolles.append(roll)
            save()
        }
}




//func remove(index: Int) {
//        let elemntPostion = (rolles.count-1) - index
//        cards.remove(at: elemntPostion)
//        save()
//    }
