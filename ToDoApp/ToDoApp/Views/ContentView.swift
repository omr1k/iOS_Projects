//
//  ContentView.swift
//  ToDoApp
//
//  Created by Omar Khattab on 06/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var realmManger = RealmManager()
    @State private var showAddView = false
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            TasksView()
                .environmentObject(realmManger)
            SmallAddButton()
                .padding()
                .onTapGesture {
                    showAddView.toggle()
                }
                
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .modifier(CustomBackGroundColor())
        .preferredColorScheme(.light)
        .sheet(isPresented: $showAddView){
            AddTaskView()
                .environmentObject(realmManger)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
