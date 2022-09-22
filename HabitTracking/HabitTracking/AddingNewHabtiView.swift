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
    
    static let color0 = Color(red: 197/255, green: 0/255, blue: 255/255);
    static let color1 = Color(red: 0/255, green: 128/255, blue: 100/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(LinearGradient(
                        gradient: gradient,
                        startPoint: .init(x: 0.00, y: 0.50),
                        endPoint: .init(x: 1.00, y: 0.50)
                    ))
                    .edgesIgnoringSafeArea(.all)
                
                Form{
                    TextField("Title",text: $title)
                        .padding()
                        .listRowBackground(Color.clear)
                        .border(.secondary, width: 2)
                        .clipShape(RoundedRectangle(cornerRadius: 15))

                    ZStack{
                        if description.isEmpty{
                            TextField("description",text: $description)
                                .padding()
                        }
                        TextEditor(text: $description)
                            .padding()
                            
                    }
                    .listRowBackground(Color.clear)
                    .border(.secondary, width: 2)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Add New Habit")
            .toolbar{
                ToolbarItem (placement: .navigationBarTrailing) {
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
                
                ToolbarItem (placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text("Ops!"),message:Text("Please add data to the fields"),dismissButton: .default(Text("OK")))
        }
        .accentColor(.white)
    }
}

struct AddingNewHabtiView_Previews: PreviewProvider {
    static var previews: some View {
        AddingNewHabtiView(HabitsObject: Habits())
    }
}
