//
//  ContentView.swift
//  FriendFace
//
//  Created by Omar Khattab on 10/09/2022.
//

import SwiftUI

struct ResponseOmar: Codable {
    var users: [User]
}

struct User:  Codable{
    var id: String
    var isActive : Bool
    var name: String
    var age: Int
    var company: String
    var email : String
    var address : String
    var registered : String
//    var Friends: [Friend]
}

struct Friend: Codable {
    var id: String
    var name: String
}

struct ContentView: View {
    var apiUrl = "https://www.hackingwithswift.com/samples/friendface.json"
    var api2 = "https://itunes.apple.com/search?term=taylor+swift&entity=song"

    @State private var users = [User]()

    var body: some View {
        NavigationView{
        List(users,id: \.id){ item in
            NavigationLink(destination: DetailView(userToShow: item)){
            HStack() {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                Spacer()
                VStack(alignment: .leading){
                    Text(item.name)
                        .font(.headline)
                    Text(item.email)
                }
                Spacer()
                Image(systemName: "circle.fill")
                    .foregroundColor(item.isActive ? .green : .red)
            }.padding(.vertical)
        }
        }
        .task{
            if users.isEmpty{
                await loadData()
                
            }else{
                print("data are alreadey loded")
            }
            
        }
        .navigationTitle("Friend Face")
        }
    }

    func loadData() async {
          let url = URL(string: "\(apiUrl)")!
          URLSession.shared.fetchData(for: url) { (result: Result<[User], Error>) in
            switch result {
            case .success(let resultData):
                users = resultData
            case .failure(let error):
                print(error)
          }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










//
//  ContentView.swift
//  FriendFace
//
//  Created by Omar Khattab on 10/09/2022.
//
//
//import SwiftUI
//
//struct Response: Codable {
//    var users: [User]
//}
//
//
//struct User:  Codable {
////    var trackId: Int
////    var trackName: String
////    var collectionName: String
//    var id: String
//    var isActive : Bool
//    var name: String
//    var age: Int
//    var company: String
//    var email : String
//    var address : String
//    var registered : String
////    var Friends: [Friend]
//}
//
//struct Friend: Codable {
//    var id: String
//    var name: String
//}
//
//struct ContentView: View {
//    var apiUrl = "https://www.hackingwithswift.com/samples/friendface.json"
//    var api2 = "https://itunes.apple.com/search?term=taylor+swift&entity=song"
//
//    @State private var users = [User]()
//
//    var body: some View {
//        List(users,id: \.id){ item in
//            VStack(alignment: .leading) {
//                Text(item.name)
//                    .font(.headline)
//                Text(item.company)
//            }
//        }
//        .task{
//            await loadData()
//        }
//    }
//
//    func loadData() async {
//        guard let url = URL(string: "\(apiUrl)") else {
//            print("Invalid URL")
//            return
//        }
//        do {
//            print("do do")
//            let (data, _) = try await URLSession.shared.data(from: url)
//            print("do do 2")
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                users = decodedResponse.users
//            }
//            print("do do 3")
//        } catch {
//            print("Invalid data")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
