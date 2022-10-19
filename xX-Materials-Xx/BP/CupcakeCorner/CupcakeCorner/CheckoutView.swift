//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Omar Khattab on 03/09/2022.
//


import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var OrderClass: OrderClass
    
    @State private var confirmationMessage = ""
    @State private var alertTitle = "Thank you!"
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .accessibilityElement() // .accessibilityElement(children: .ignore) defult value is ignoring children

                Text("Your total is \(OrderClass.orderInit.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("\(alertTitle)", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(OrderClass.orderInit) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            let decodedOrder = try JSONDecoder().decode(orderStruct.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(orderStruct.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true

        } catch {
            print("Checkout failed.")
            alertTitle = "Error!!"
            confirmationMessage = "Failed to place your order, kindly check your internet connection"
            showingConfirmation = true
        }
    } // place order end
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(OrderClass: OrderClass.init())
    }
}


//xxxxxxxxxxxxxx
//import SwiftUI
//
//struct CheckoutView: View {
//
//    @ObservedObject var order: Order
//    @State private var confirmationMessage = ""
//    @State private var alertTitle = "Thank you!"
//    @State private var showingConfirmation = false
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
//                        image
//                            .resizable()
//                            .scaledToFit()
//                } placeholder: {
//                    ProgressView()
//                }
//                .frame(height: 233)
//
//                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
//                    .font(.title)
//
//                Button("Place Order", action: {
//                    Task {
//                        await placeOrder()
//                    }
//                })
//                    .padding()
//            }
//        }
//        .navigationTitle("Check out")
//        .navigationBarTitleDisplayMode(.inline)
//        .alert("\(alertTitle)", isPresented: $showingConfirmation) {
//            Button("OK") { }
//        } message: {
//            Text(confirmationMessage)
//        }
//    }
//
//
//    func placeOrder() async {
//
//        guard let encoded = try? JSONEncoder().encode(order) else {
//            print("Failed to encode order")
//            return
//        }
//
//        let url = URL(string: "https://reqres.in/api/cupcakes")!
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//
//        do {
//            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
//            // handle the result
//            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
//            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
//            showingConfirmation = true
//
//        } catch {
//            print("Checkout failed.")
//            alertTitle = "Error!!"
//            confirmationMessage = "Failed to place your order, kindly check your internet connection"
//            showingConfirmation = true
//        }
//    }
//
//}
//
//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView(order: Order())
//    }
//}
