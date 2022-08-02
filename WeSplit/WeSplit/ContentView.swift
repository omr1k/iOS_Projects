//
//  ContentView.swift
//  WeSplit
//
//  Created by Omar Khattab on 21/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var numberOfPeopleV2 = 1
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var useRedText = false


    let tipPercentages = [0,10, 15, 20, 25]
    
    var totalPerPerson: Double {

        let peopleCount = Double(numberOfPeople + 2)
        let peopleCount2 = Double (numberOfPeopleV2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount2
        
        return amountPerPerson
    }
    

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                                    .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .keyboardType(.decimalPad)
                                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 100) {
                                Text("\($0) people")
                            }
                    }
                    
                
                    TextField("Number of people v2",value: $numberOfPeopleV2,format:.number)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                
                
                }

                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .blue)
                   }
                
                
                } // form end
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement:.keyboard){
                    Spacer()
                    Button("Omar Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
