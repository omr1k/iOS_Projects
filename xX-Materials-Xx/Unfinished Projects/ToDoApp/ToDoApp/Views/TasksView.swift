//
//  TasksView.swift
//  ToDoApp
//
//  Created by Omar Khattab on 06/12/2022.
//

import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var realmManger : RealmManager
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(realmManger.tasks, id: \.id){ task in
                        // Must wrap in an if statement because we don't want to display the task if it has been invalidated (will run into a crash otherwise)
                        if  !task.isInvalidated {
                        TaskRow(task: task.title, completed: task.completed)
                            .onTapGesture {
                                realmManger.updateTask(id: task.id, completed: !task.completed)
                            }
                            .swipeActions(edge: .trailing){
                                Button(role: .destructive){
                                    realmManger.deleteTask(id: task.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                       }
                    }
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(CustomBackGroundColor())
            
            .navigationTitle("My Tasks")
        }
        
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(RealmManager())
    }
}
