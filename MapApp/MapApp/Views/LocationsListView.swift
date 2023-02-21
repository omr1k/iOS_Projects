//
//  LocationsListView.swift
//  MapApp
//
//  Created by Omar Khattab on 13/02/2023.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var currentLocationId: UUID = UUID()
    var body: some View {
        List{
            ForEach(vm.savedLocations){ location in
                Button {
                    vm.showNextLocation(newLocation: location)
                    
                } label: {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .bold()
                            .foregroundColor(.primary)
                            .padding(5)
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                            Text("Date added: \(location.dateAdded)")
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .onDelete(perform: deleteElment)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}


extension LocationsListView {
    func deleteElment(at offsets: IndexSet){
        for index in offsets.makeIterator() {
            print("index in fl \(index)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation(.easeOut){
                    vm.deleteElement(index: index)
                }
            }
        }
    }
}







////
////  LocationsListView.swift
////  MapApp
////
////  Created by Omar Khattab on 13/02/2023.
////
//
//import SwiftUI
//
//struct LocationsListView: View {
//    @EnvironmentObject private var vm: LocationsViewModel
//
//    var body: some View {
//        List{
//            ForEach(vm.locations){ location in
//
//                Button {
//                    print("ssds")
////                    vm.showNextLocation(newLocation: location)
//                } label: {
//                    HStack{
//                        if let image = location.imageNames.first {
//                            Image(image)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 55,height: 55)
//                                .cornerRadius(10)
//
//                            VStack(alignment: .leading) {
//                                Text(location.name)
//                                    .font(.headline)
//                                Text(location.cityName)
//                                    .font(.body)
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                    }
//                }
//            }
//            .listRowBackground(Color.clear)
//            .listRowSeparator(.hidden)
//        }
//        .scrollContentBackground(.hidden)
//        .listStyle(PlainListStyle())
//
//
//    }
//}
//
//struct LocationsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationsListView()
//            .environmentObject(LocationsViewModel())
//    }
//}
