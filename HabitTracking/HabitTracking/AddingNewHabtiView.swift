//
//  AddingNewHabtiView.swift
//  HabitTracking
//
//  Created by Omar Khattab on 22/08/2022.
//

import SwiftUI

struct AddingNewHabtiView: View {
    
    @ObservedObject var HabitsObject : Habits
    @Environment(\.dismiss) var dismiss
    @State private var title=""
    @State private var description=""
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationView{
            
            Form{
            TextField("Title",text: $title)
            .padding()
                
                TextField("description",text: $description)
                    .padding()
        }
            .navigationTitle("Add New Habit")
            .toolbar{
                Button("Save"){
                    if title != "" && description != ""{
                    
                    let item = HabitItem(title: title, description: description,compCount: 1)
                    HabitsObject.items.append(item)
                    dismiss()
                        
                    }else{
                        showAlert.toggle()
                    }
                    
                }
            }
            
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text("Ops"),message:Text("Please add value to the faildes"),dismissButton: .default(Text("OK")))
        }
    }
}

struct AddingNewHabtiView_Previews: PreviewProvider {
    static var previews: some View {
        AddingNewHabtiView(HabitsObject: Habits())
    }
}
