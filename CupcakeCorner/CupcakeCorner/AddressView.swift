//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Omar Khattab on 02/09/2022.
//
import SwiftUI

struct AddressView: View {
    @ObservedObject var OrderClass: OrderClass
    
    
    var body: some View {

        Form {
            Section {
                TextField("Name", text: $OrderClass.orderInit.name)
                    .foregroundColor(OrderClass.orderInit.nameValidation ? .green : .red)
                TextField("Street Address", text: $OrderClass.orderInit.streetAddress)
                    .foregroundColor(.green)
                TextField("City", text: $OrderClass.orderInit.city)
                    .foregroundColor(OrderClass.orderInit.cityValidation ? .green : .red)
                TextField("Zip", text: $OrderClass.orderInit.zip)
                    .foregroundColor(OrderClass.orderInit.zipValidation ? .green : .red)
            }

            Section {
                NavigationLink {
                    CheckoutView(OrderClass: OrderClass.self)
                } label: {
                    Text("Check out")
                }
            }.disabled(OrderClass.orderInit.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(OrderClass: OrderClass())
    }
}




//xxxxxxxxxxxxxx
//import SwiftUI
//
//struct AddressView: View {
//    @ObservedObject var order: Order
//
//
//    var body: some View {
//
//        Form {
//            Section {
//                TextField("Name", text: $order)
//                    .foregroundColor(order.nameValidation ? .green : .red)
//                TextField("Street Address", text: $order.streetAddress)
//                    .foregroundColor(.green)
//                TextField("City", text: $order.city)
//                    .foregroundColor(order.cityValidation ? .green : .red)
//                TextField("Zip", text: $order.zip)
//                    .foregroundColor(order.zipValidation ? .green : .red)
//            }
//
//            Section {
//                NavigationLink {
//                    CheckoutView(order: order)
//                } label: {
//                    Text("Check out")
//                }
//            }.disabled(order.hasValidAddress == false)
//        }
//        .navigationTitle("Delivery details")
//        .navigationBarTitleDisplayMode(.inline)
//
//    }
//}
//
//struct AddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddressView(order: Order())
//    }
//}
