//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Omar Khattab on 06/12/2022.
//

import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject var realmManger : RealmManager
    @State private var taskTitle = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 20){
                VStack{
                    TextField("Enter task to do", text: $taskTitle, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .cornerRadius(15)
                Spacer()
                HStack{
                    Button {
                        if taskTitle != ""{
                            realmManger.addTask(taskTitle: taskTitle)
                        }
                        dismiss()
                    } label: {
                        Text("Add to do task")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(15)
                        
                    }
                }
        }
            
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding()
            .modifier(CustomBackGroundColor())
            .navigationTitle("Create New Task")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(RealmManager())
    }
}
