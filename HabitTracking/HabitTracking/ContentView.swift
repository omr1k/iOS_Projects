//
//  ContentView.swift
//  HabitTracking
//
//  Created by Omar Khattab on 22/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAddsheet = false
    @ObservedObject var habits = Habits()
    
    //@StateObject var HabitsObject = Habits()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<habits.items.count, id: \.self) { index in
                    NavigationLink(destination: DetailsScreen(habit: self.$habits.items[index])) {
                        HStack{
                                Text(habits.items[index].title)
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                                Spacer()
                                Text("\(habits.items[index].compCount)")
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            
                            }
                            .padding(40)
                            .frame(maxWidth: .infinity)
                            .background(.thinMaterial)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } // link end
                } // foreach end
                .onDelete(perform: reomveItem)
            }// list end
            
            
            .navigationTitle("Habit Tracking")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        print("Plus icon pressed...")
                        showAddsheet = true
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }
            )
            .sheet(isPresented: $showAddsheet) {
                AddingNewHabtiView(HabitsObject: habits)
            }
            
        }
    }
    func reomveItem(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}


extension Sequence {
    func indexed() -> Array<(offset: Int, element: Element)> {
        return Array(enumerated())
    }
}
















//  ContentView.swift
//  HabitTracking
//
//  Created by Omar Khattab on 22/08/2022.
//
//
//import SwiftUI
//
//struct ContentView: View {
//
//  @StateObject var habitsInContent = Habits()
//  @State private var showAddsheet = false
//
//
//  var body: some View {
//    NavigationView {
//            List{
//                ForEach(habitsInContent.items) { item in
//
//                    NavigationLink(destination: DetailsScreen(title: item.title, disc: item.description)) {
//                            Text(item.title)
//                            .padding()
//                        }
//                }.onDelete(perform: reomveItem)
//            } // list end
//
//
//
//        .navigationTitle("Habit Tracking")
//        .navigationBarItems(
//          trailing:
//
//            Button(action: {
//              print("Plus icon pressed...")
//              showAddsheet = true
//            }) {
//              Image(systemName: "plus").imageScale(.large)
//            }
//        )
//        .sheet(isPresented: $showAddsheet) {
//            AddingNewHabtiView(HabitsObject: habitsInContent)
//        }
//    }
//  }
//
//        func reomveItem(at offsets:IndexSet){
//            habitsInContent.items.remove(atOffsets: offsets)
//        }
//}
//
//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}

