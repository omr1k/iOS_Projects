//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Omar Khattab on 19/11/2022.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    
    @State var resorts: [Resort] = Bundle.main.decode("resorts.json")

    enum sortType {
        case def, Alphabetical, Countery
    }
    
    func sortResortBy(sorType : sortType) -> [Resort]{
        switch sorType {
            
        case .def:
            return Bundle.main.decode("resorts.json")
        case .Alphabetical :
            return resorts.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
        case .Countery:
            return resorts.sorted(by: {$0.country.lowercased() < $1.country.lowercased()})
            
        }
    }
    
    
    @State private var searchText = ""

    @StateObject var favorites = Favorites()
    
    @State private var showFilterDialog = false

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                    
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button {
                    print("ajkfd")
                    showFilterDialog = true
                } label: {
                    Label("Show", systemImage: "arrow.up.arrow.down.square")
                        .foregroundColor(.blue)
                }
            }
            .confirmationDialog("Sort the Table", isPresented: $showFilterDialog, titleVisibility: .visible){
                Button("Default Order") {
                    resorts = sortResortBy(sorType: .def)
//                    resorts = Bundle.main.decode("resorts.json")
                   
                }
                Button("Alphabetical Order") {
                    resorts = sortResortBy(sorType: .Alphabetical)
//                    resorts = resorts.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
                }
                
                Button("By Countery") {
                    resorts = sortResortBy(sorType: .Countery)
//                    resorts = resorts.sorted(by: {$0.country.lowercased() < $1.country.lowercased()})
                }
                
            }

            WelcomeView()

        }
        .environmentObject(favorites)

        .phoneOnlyStackNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
