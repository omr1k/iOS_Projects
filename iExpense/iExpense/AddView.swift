//
//  AddView.swift
//  iExpense
//
//  Created by Omar Khattab on 16/08/2022.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var ExpensesObject : Expenses
    @Environment(\.dismiss) var dismiss
    @State private var name=""
    @State private var type="Personal"
    @State private var amount=0.0
    @State private var currency="USD"
    
    let types = ["Personal","Business"]
    let currencies = ["USD","EUR","IQD","JOD"]
    
    var body: some View {
        NavigationView{
            Form{
            TextField("Name",text: $name)
            
            Picker("Type", selection: $type){
                ForEach(types,id: \.self){
                    Text($0)
                }
            }.pickerStyle(.inline)
               
                HStack{
//                    TextField("Amount",value: $amount,format: .currency(code: "USD")).keyboardType(.decimalPad)
                    
                    TextField("Amount",value: $amount,format: .number).keyboardType(.decimalPad)
                    
                    Picker("Currency", selection: $currency){
                        ForEach(currencies,id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                     
                }.padding()
                
        }
            .navigationTitle("Add Next Expense")
            .toolbar{
                Button("Save"){
                    let item =  ExpenseItem(name: name, type: type, amount: amount,currency: currency)
                    ExpensesObject.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(ExpensesObject: Expenses())
    }
}
