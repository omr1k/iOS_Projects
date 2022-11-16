//
//  ContentView.swift
//  RollTheDice
//
//  Created by Omar Khattab on 15/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var selectedNumberOFDicesValue = 1
    @State private var selectedNumberOFSidesValue = 4
    
    @State private var FinalValue = ""
   
    
    let NumberOfDices = [1, 2, 3, 4,5,6]
    let DicesSides = [4, 6, 8, 10,12,20,100]
    
    @EnvironmentObject var rollesObject : Rolles
    let rollesClass = Rolles()
    

    
    var body: some View {
        VStack{
            List{
                Section{
                    Picker("Please choose", selection: $selectedNumberOFDicesValue) {
                        ForEach(NumberOfDices, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How Many Dices?")
                        .textCase(nil)
                }
                
                Section{
                    Picker("Please choose", selection: $selectedNumberOFSidesValue) {
                        ForEach(DicesSides, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How Many Sides?")
                        .textCase(nil)
                }
                
            }
            
            
            
            Text(FinalValue)
            HStack{
                Button("Roll Dice") {
                    RollDice()
                }.onTapGesture(perform: simpleSuccess)
                Spacer()
                Button("Delete all") {
                    
                    rollesClass.DeleteAll()
                    
                    selectedNumberOFDicesValue = 2
                    selectedNumberOFSidesValue = 6
                    
                    selectedNumberOFSidesValue = 4
                    selectedNumberOFDicesValue = 1
                    print("delete done")
                }
            }.padding()
            
            HStack{
                Text("Number of dices")
                Spacer()
                Text("Dice Size")
                Spacer()
                Text("Results")
                Spacer()
                Text("Sum")
            }.padding()
            
            ScrollView(.vertical){
                Section {
                    ForEach(rollesClass.rolles.reversed()) { roll in
                        HStack() {
                            Text("\(roll.numberOfDices)")
                                .font(.footnote)
                            Spacer()
                            
                            Text("\(roll.diceSize)")
                                .font(.footnote)
                            Spacer()
                            ForEach(roll.diceResult, id: \.self) {
                                Text("\($0)")
                                    .font(.footnote)
                            }
                            Spacer()
                            Text("\(roll.total)")
                                .font(.footnote)
                        }
                    }
                }.padding()
            }
            
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func RollDice () {
        
        var arrayOfSingleDice = [Int]()
        var randomResult = [Int]()
        
        for i in 1...selectedNumberOFSidesValue {
            arrayOfSingleDice.append(i)
        }
        
        for _ in 1...selectedNumberOFDicesValue {
            let randomValue = arrayOfSingleDice.randomElement()!
            randomResult.append(randomValue)
        }

        let total = randomResult.reduce(0, +)
        let roll = Roll(numberOfDices: selectedNumberOFDicesValue, diceSize: selectedNumberOFSidesValue, diceResult: randomResult, total: total)
        print("roll \(roll)")
        rollesClass.add(roll)
        print(rollesClass.rolles)
        
        selectedNumberOFDicesValue = 2
        selectedNumberOFSidesValue = 6
        
        selectedNumberOFSidesValue = 4
        selectedNumberOFDicesValue = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
