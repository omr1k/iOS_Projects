//
//  Card.swift
//  Flashzilla
//
//  Created by Omar Khattab on 29/10/2022.
//

import Foundation

struct Card: Identifiable, Codable {
    var id = UUID()
    let prompt : String
    let answer : String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")

}



@MainActor class Cards: ObservableObject {
    @Published private(set) var cards: [Card]
    let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedCards")
    
    init() {
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            cards = try decoder.decode([Card].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            cards = [].reversed()
        }
    }
    
    private func save() {
            do {
                print("save Path====>\(jsonFilePath.path)")
                let data = try JSONEncoder().encode(cards)
                try data.write(to: jsonFilePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        

    
        func add(_ card: Card) {
            cards.append(card)
            save()
        }
    
    func remove(index: Int) {
            let elemntPostion = (cards.count-1) - index
            cards.remove(at: elemntPostion)
            save()
        }
    
}
