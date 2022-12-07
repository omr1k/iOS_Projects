//
//  TaskRow.swift
//  ToDoApp
//
//  Created by Omar Khattab on 06/12/2022.
//

import SwiftUI

struct TaskRow: View {
    
    var task : String
    var completed :Bool
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: completed ? "checkmark.circle.fill" : "circle")
            Text(task)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "My Task", completed: true)
    }
}
