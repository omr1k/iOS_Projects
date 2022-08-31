//
//  DetailsScreen.swift
//  HabitTracking
//
//  Created by Omar Khattab on 23/08/2022.
//

import SwiftUI

struct DetailsScreen: View {
    
    @Binding var habit: HabitItem
    
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                Text(habit.title)
                    .font(.title)
                    .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("\(habit.compCount)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                VStack{
                    Text("\(habit.title) Description")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                        .padding()
                        
                    
                    
                    VStack{
                        Text(habit.description)
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
                    .padding()
                    .background(Color(0x0F3460))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .padding()
                .background(Color(0xE94560))
                .clipShape(RoundedRectangle(cornerRadius: 25))
        
                Button("Mark Completed"){
                    self.habit.incrementAmount()
                }
                .buttonStyle(RoundedRectangleWithShadowedLabelButtonStyle())
                .padding()
            }
        }
        .padding()
        .navigationTitle(habit.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct RoundedRectangleWithShadowedLabelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
                .shadow(
                    color: configuration.isPressed ? Color.red : Color.red,
                    radius: 4, x: 0, y: 5
                )
            Spacer()
        }
        .padding()
        .background(Color(0x0F3460).cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}




public extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}









//
//if HabitsObject.items.indices.contains(index) {
//   print("omar")
//}

//struct DetailsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsScreen(title: "t", disc: "t",compCount: 0)
//    }
//}











////
////  DetailsScreen.swift
////  HabitTracking
////
////  Created by Omar Khattab on 23/08/2022.
////
//
//import SwiftUI
//
//struct DetailsScreen: View {
//
////    let title: String
////    let disc: String
//    @StateObject var habitsInDetailsScreen = Habits()
//    @State private var counter = 0
//
////    @AppStorage("CountXX") var counterXX = 0
//
//    var body: some View {
//        ScrollView{
//            HStack{
////                Text("Completion \(habitsInDetailsScreen.compCount)")
//                Button(action: {
//                    counter+=1
////                    habitsInDetailsScreen.compCount = counter
//                }) {
//                    Image(systemName: "plus").imageScale(.large)
//                }
//            }
//
//            Text(habitsInDetailsScreen.description)
//
//            .navigationTitle(habitsInDetailsScreen.title)
//                .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//
//
//
//struct DetailsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsScreen()
//    }
//}







//
//    let title: String
//    let disc: String
//    let compCount : Int
//    @StateObject var habitsInDetailsScreen = Habits()
//    @State private var counter = 0
////    @AppStorage("CountXX") var counterXX = 0




//     func incrementCount() {
//                // here is the ugly part where I would have preferred to use an ObservedObject and mutate it directly
//                if let index == HabitsObject.items.firstIndex(where: { $0.id == habit.id }) {
//                    var newActivity = HabitsObject.items[index]
//                    newActivity.compCount += 1
//                    HabitsObject.items[index].compCount = newActivity
//                    habit = newActivity
//                }
//            }
//


//                var count = habitsInDetailsScreen.items[index].compCount
//                count+=1
//                habitsInDetailsScreen.items[index].compCount = count
