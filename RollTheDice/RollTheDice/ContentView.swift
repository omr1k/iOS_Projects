//
//  ContentView.swift
//  RollTheDice
//
//  Created by Omar Khattab on 15/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var selectedNumberOFDicesValue = "1"
    @State private var selectedNumberOFSidesValue = "4"
    
    @State private var FinalValue = ""
    var resultArray = [String]()
    
    let NumberOfDices = ["1", "2", "3", "4","5","6"]
    let DicesSides = ["4", "6", "8", "10","12","20"]
    
    @EnvironmentObject var rollesObject : Rolles
    let rollesClass = Rolles()
    var body: some View {
        
        VStack{
            List{
                
                Section{
                    Picker("Please choose", selection: $selectedNumberOFDicesValue) {
                        ForEach(NumberOfDices, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How Many Dices?")
                        .textCase(nil)
                }
                
                Section{
                    Picker("Please choose", selection: $selectedNumberOFSidesValue) {
                        ForEach(DicesSides, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How Many Sides?")
                        .textCase(nil)
                }
                
            }
            
            Text(FinalValue)
            Button("Roll Now") {
                RollDice()
            }
            
            
            HStack{
                Spacer()
                Text("Dice Size")
                Spacer()
                Text("Dice Result")
                Spacer()
            }.padding()
            ScrollView(.vertical){
                Section {
                    ForEach(rollesClass.rolles.reversed()) { roll in
                        HStack() {
                            Spacer()
                            Text(roll.diceSize)
                                .font(.headline)
                            Spacer()
                            Text(roll.diceresult)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                }.padding()
            }
            
        }
    }
    
    func RollDice () {
        var arrayOfSingleDice = [String]()
        let selectedNumberOFSidesValueINT = Int(selectedNumberOFSidesValue)!
        
        for i in 1...selectedNumberOFSidesValueINT {
            arrayOfSingleDice.append(String(i))
        }
        print(arrayOfSingleDice)
        
        
        var xxx = [String]()
        for _ in 1...Int(selectedNumberOFDicesValue)!{
            var randomValue = arrayOfSingleDice.randomElement()!
            xxx.append(randomValue)
        }
        
        print("resutl array \(xxx)")
        
        
//        FinalValue = arrayOfSingleDice.randomElement()!
        let roll = Roll(diceSize: selectedNumberOFSidesValue, diceresult: FinalValue)
        rollesClass.add(roll)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
