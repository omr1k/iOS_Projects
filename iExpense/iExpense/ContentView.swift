//
//  ContentView.swift
//  iExpense
//
//  Created by Omar Khattab on 16/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showAddsheet = false
    @State private var colorToggle = false


    
    var body: some View {
        NavigationView{
                List{
                    Section (header: Text("Business")) {
                      ForEach(expenses.businessItems) { item in
                        HStack {
                          VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                          }

                          Spacer()
                          // Challenges 1 and 2, format and conditional coloring
                          Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "zh-Hant-HK"))
                            .foregroundColor(item.amount < 10 ? .red : item.amount > 100 ? .blue : .orange)
                        }
                      }
                      .onDelete(perform: removeBusinessItems)
                    }

                    Section (header: Text("Personal")) {
                      ForEach(expenses.personalItems) { item in
                        HStack {
                          VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                          }

                          Spacer()
                          // Challenges 1 and 2, format and conditional coloring
                          Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "zh-Hant-HK"))
                            .foregroundColor(item.amount < 10 ? .red : item.amount > 100 ? .blue : .orange)
                        }
                      }
                      .onDelete(perform: removePersonalItems)
                    }

                    
               } // list end
                
//                List{
//                    ForEach(expenses.items) { item in
//
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(item.name)
//                                        .font(.headline)
//                                    Text(item.type)
//                                }
//                                Spacer()
//                                Text(item.amount, format: .currency(code: "\(item.currency)"))
//                                    .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .yellow : .red)
//                            }
//
//                    }.onDelete(perform: reomveItem)// foreach end
//               } // list end
//
            .navigationTitle("iExpense")
            .toolbar{
                Button{
//                    let e = ExpenseItem(name: "Text", type: "personal", amount: 5)
//                    expenses.items.append(e)
                    showAddsheet=true
                }label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddsheet){
                AddView(ExpensesObject: expenses)
            }
        }
    }
    
    
    
//    func reomveItem(at offsets:IndexSet){
//        expenses.items.remove(atOffsets: offsets)
//    }
    
    func removePersonalItems(at offsets: IndexSet) {

      // look at each item we are trying to delete
      for offset in offsets {

        // look in the personalItems array and get that specific item we are trying to delete. Find it's corresponding match in the expenses.items array.
          if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalItems[offset].id}) {

          // delete the item from the expenses.items array at the index you found its match
            expenses.items.remove(at: index)

          }
        }
      }
    
    
    func removeBusinessItems(at offsets: IndexSet) {

      // look at each item we are trying to delete
      for offset in offsets {

        // look in the personalItems array and get that specific item we are trying to delete. Find it's corresponding match in the expenses.items array.
          if let index = expenses.items.firstIndex(where: {$0.id == expenses.businessItems[offset].id}) {

          // delete the item from the expenses.items array at the index you found its match
            expenses.items.remove(at: index)

          }
        }
      }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
