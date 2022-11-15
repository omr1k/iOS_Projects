//
//  AddView.swift
//  Flashzilla
//
//  Created by Omar Khattab on 05/11/2022.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cardsObject : Cards
    let cardsClass = Cards()
    @State private var prompt = ""
    @State private var answer = ""
    
    
    var body: some View {
        NavigationView(){
            ZStack{
                List {
                    Section("Add new card") {
                        TextField("Prompt", text: $prompt)
                        TextField("Answer", text: $answer)
                        Button("Add card", action: addCard)
                    }
                    
                    Section {
                        ForEach(cardsClass.cards.reversed()) { card in
                            VStack(alignment: .leading) {
                                Text(card.prompt)
                                    .font(.headline)
                                Text(card.answer)
                                    .foregroundColor(.secondary)
                            }
                        }.onDelete(perform: deletequstion)
                    }
                }
            }
            .navigationTitle("Add a new card")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func addCard(){
        let card = Card(prompt: prompt, answer: answer)
        cardsClass.add(card)
        prompt=""
        answer=""
    }
    
    func done(){
        dismiss()
    }
    
    func deletequstion(at offsets: IndexSet){
        for i in offsets.makeIterator() {
            cardsClass.remove(index: i)
        }
        print("This is delete fucntion")
    }
    
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}




//@State private var cardsArray = [Cards]()
