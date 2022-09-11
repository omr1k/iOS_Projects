//
//  ContentView.swift
//  FriendFace
//
//  Created by Omar Khattab on 10/09/2022.
//

import SwiftUI

struct ContentView: View {
  var apiUrl = "https://www.hackingwithswift.com/samples/friendface.json"
  var api2forTesting = "https://itunes.apple.com/search?term=taylor+swift&entity=song"

  @State private var users = [User]()
    
    static let color0 = Color(red: 240/255, green: 81/255, blue: 56/255);
    static let color1 = Color(red: 3/255, green: 169/255, blue: 244/255);
    let gradient = Gradient(colors: [color0, color1]);

  var body: some View {
    
  NavigationView {
  
      ZStack{
          Rectangle()
                  .fill(LinearGradient(
                    gradient: gradient,
                    startPoint: .init(x: 0.00, y: 0.50),
                    endPoint: .init(x: 1.00, y: 0.50)
                  ))
                .edgesIgnoringSafeArea(.all)
      
          
          VStack{
              Text("")
                  .frame(width: 0, height: 0, alignment: .center)
                  .foregroundColor(.clear)
              
      List(users) { user in
        NavigationLink(destination: DetailView(userToShow: user)) {
          HStack {
            Image(systemName: "person.crop.circle.fill")
              .resizable()
              .frame(width: 40, height: 40)
              
            VStack(alignment: .leading) {
              Text(user.name)
                .font(.headline)
              Text(user.isActive ? "Active" : "Offline")
                    .foregroundColor(user.isActive ? .green : .secondary)
            }.padding(.horizontal)
              Spacer()
              Image(systemName: "circle.fill")
                  .foregroundColor(user.isActive ? .green : .secondary)
                  .overlay(
                    Circle()
                        .stroke(Color.secondary, lineWidth: 1)
                  )
          }.padding(.vertical)
        }
        .listRowBackground(Color.clear)
//        .listRowSeparator(.hidden)
//        .background(Color.clear)
        
      }.task {
          print("before parsing \(users.count)")
          if let retrievedUsers = await loadData() {
              users = retrievedUsers
              print("After parsing \(users.count)")
          }
      }
      .onAppear(){
          UITableView.appearance().backgroundColor = UIColor.clear
          UITableViewCell.appearance().backgroundColor = UIColor.clear
      }
      }// parent vstack end
      
  }// zend
      .preferredColorScheme(.dark)
      .navigationTitle("Friend Face")
      
  }.accentColor(.black)
  }

  func loadData() async -> [User]? {
    let url = URL(string: "\(apiUrl)")!
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      do {
          let (data, _) = try await URLSession.shared.data(for: request)
          let decodedData = try decoder.decode([User].self, from: data)
          return decodedData
      } catch {
          print(error)
      }
      return nil
  }
  
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}












////
////  ContentView.swift
////  FriendFace
////
////  Created by Omar Khattab on 10/09/2022.
////
//
//import SwiftUI
//
////struct ResponseOmar: Codable {
////    var users: [User]
////}
////
////struct User:  Codable{
////    var id: String
////    var isActive : Bool
////    var name: String
////    var age: Int
////    var company: String
////    var email : String
////    var address : String
////    var registered : String
//////    var Friends: [Friend]
////}
////
////struct Friend: Codable {
////    var id: String
////    var name: String
////}
//
//struct ContentView: View {
//  var apiUrl = "https://www.hackingwithswift.com/samples/friendface.json"
//  var api2forTesting = "https://itunes.apple.com/search?term=taylor+swift&entity=song"
//
//  @State private var users = [User]()
//
//  var body: some View {
//    NavigationView {
//      List(users, id: \.id) { item in
//        NavigationLink(destination: DetailView(userToShow: item)) {
//          HStack {
//            Image(systemName: "person.crop.circle.fill")
//              .resizable()
//              .frame(width: 32.0, height: 32.0)
//            Spacer()
//            VStack(alignment: .leading) {
//              Text(item.name)
//                .font(.headline)
//              Text(item.email)
//            }
//            Spacer()
//            Image(systemName: "circle.fill")
//              .foregroundColor(item.isActive ? .green : .red)
//          }.padding(.vertical)
//        }
//      }
//      .task {
//        if users.isEmpty {
//          await loadData()
//        } else {
//          print("data are alreadey loded")
//        }
//      }
//      .navigationTitle("Friend Face")
//    }
//  }
//
//  func loadData() async {
//    let url = URL(string: "\(apiUrl)")!
//    URLSession.shared.fetchData(for: url) { (result: Result<[User], Error>) in
//      switch result {
//      case .success(let resultData):
//        users = resultData
//      case .failure(let error):
//        print(error)
//      }
//    }
//  }
//}
//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}


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
