//
//  EditView2.swift
//  BucketList
//
//  Created by Omar Khattab on 26/09/2022.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    @State private var loadingState = LoadingState.loading
    
    @State private var pages = [Page]()
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby…") {
                    switch loadingState {
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
                
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
            .task {
                loadingState = .loading
                if let responseData = await NetworkManager().fetchNearbyPlaces(location: location){
                    pages = responseData
                    loadingState = .loaded
                }else{
                    loadingState = .failed
                }
//              pages = await NetworkManager().fetchNearbyPlaces(location: location)!
              print(pages)
            }

        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}


struct EditView2_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { newLocation in }
    }
}



//===== Classic Edit View =====

//import SwiftUI
//
//struct EditView: View {
//
//    @Environment(\.dismiss) var dismiss
//
//    var location: Location
//    var onSave: (Location) -> Void
//
//    @State private var name: String
//    @State private var description: String
//    @State private var loadingState = LoadingState.loading
//    @State private var pages = [Page]()
//
//    enum LoadingState {
//        case loading, loaded, failed
//    }
//
//
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    TextField("Place name", text: $name)
//                    TextField("Description", text: $description)
//                }
//
//                Section("Nearby…") {
//                    switch loadingState {
//                    case .loaded:
//                        ForEach(pages, id: \.pageid) { page in
//                            Text(page.title)
//                                .font(.headline)
//                            + Text(": ") +
//                            Text(page.description)
//                                .italic()
//                        }
//                    case .loading:
//                        Text("Loading…")
//                    case .failed:
//                        Text("Please try again later.")
//                    }
//                }
//
//            }
//            .navigationTitle("Place details")
//            .toolbar {
//                Button("Save") {
//                    var newLocation = location
//                    newLocation.id = UUID()
//                    newLocation.name = name
//                    newLocation.description = description
//
//                    onSave(newLocation)
//
//                    dismiss()
//                }
//            }
//            .task {
//                await fetchNearbyPlaces()
//            }
//
//        }
//    }
//
//    init(location: Location, onSave: @escaping (Location) -> Void) {
//        self.location = location
//        self.onSave = onSave
//
//        _name = State(initialValue: location.name)
//        _description = State(initialValue: location.description)
//    }
//
//    func fetchNearbyPlaces() async {
//        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
//
//        guard let url = URL(string: urlString) else {
//            print("Bad URL: \(urlString)")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            // we got some data back!
//            let items = try JSONDecoder().decode(Result.self, from: data)
//
//            // success – convert the array values to our pages array
//            pages = items.query.pages.values.sorted()
//            loadingState = .loaded
//        } catch {
//            // if we're still here it means the request failed somehow
//            loadingState = .failed
//        }
//    }
//
//}
//
//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(location: Location.example) { newLocation in }
//    }
//}

