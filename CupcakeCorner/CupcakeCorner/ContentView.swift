//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Omar Khattab on 31/08/2022.
//


import SwiftUI

struct ContentView: View {
//    @StateObject var orderClass = OrderClass()
    @ObservedObject var orderClass = OrderClass()


    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderClass.orderInit.type) {
                        ForEach(orderStruct.types.indices) {
                            Text(orderStruct.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(orderClass.orderInit.quantity)", value: $orderClass.orderInit.quantity, in: 1...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderClass.orderInit.specialRequestEnabled.animation())

                    if orderClass.orderInit.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderClass.orderInit.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $orderClass.orderInit.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(OrderClass: orderClass)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//xxxxxxxxxxxxxx
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var order = Order()
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    Picker("Select your cake type", selection: $order.type) {
//                        ForEach(Order.types.indices) {
//                            Text(Order.types[$0])
//                        }
//                    }
//
//                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
//                }
//
//                Section {
//                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
//
//                    if order.specialRequestEnabled {
//                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
//
//                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
//                    }
//                }
//
//                Section {
//                    NavigationLink {
//                        AddressView(order: order)
//                    } label: {
//                        Text("Delivery details")
//                    }
//                }
//            }
//            .navigationTitle("Cupcake Corner")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
