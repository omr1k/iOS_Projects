//
//  ContentView.swift
//  FriendFace
//
//  Created by Omar Khattab on 14/09/2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.isActive)]) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    static let color0 = Color(red: 240 / 255, green: 81 / 255, blue: 56 / 255)
    static let color1 = Color(red: 3 / 255, green: 169 / 255, blue: 244 / 255)
    let gradient = Gradient(colors: [color0, color1])
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .init(x: 0.00, y: 0.50),
                            endPoint: .init(x: 1.00, y: 0.50)
                        )
                    )
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("")
                        .frame(width: 0, height: 0, alignment: .center)
                        .foregroundColor(.clear)
                    List(cachedUsers) { user in
                        NavigationLink(destination: DetailView(userToShow: user)) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading) {
                                    Text(user.wrappedName)
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
                        }.listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                    .refreshable {users = await NetworkManager().getUsers()!}
                    .task {
                        print("bfore \(users.count)")
                        users = await NetworkManager().getUsers()!
                        print("after\(users.count)")
                        
                        delete(entityName1: "CachedFriend", entityName2: "CachedUser")
                        
                        await MainActor.run {
                            for user in users {
                                let newUser = CachedUser(context: moc)
                                newUser.name = user.name
                                newUser.id = user.id
                                newUser.isActive = user.isActive
                                newUser.age = Int16(user.age)
                                newUser.about = user.about
                                newUser.email = user.email
                                newUser.address = user.address
                                newUser.company = user.company
                                newUser.formattedDate = user.formattedDate
                                
                                for friend in user.friends {
                                    let newFriend = CachedFriend(context: moc)
                                    newFriend.id = friend.id
                                    newFriend.name = friend.name
                                    newFriend.user = newUser
                                }
                                try? moc.save()
                            }
                            
                        }
                    }// task end
                    
                } // vstack end
            }//zsatck end
            
            
            
            .navigationTitle("Friend Face")
            .preferredColorScheme(.dark)
        }.accentColor(.white)
    }
    
    func delete(entityName1: String, entityName2: String) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName1)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        let batchDelete = try! moc.execute(deleteRequest) as? NSBatchDeleteResult
        guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }
        let deletedObjects: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult]
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [moc]
        )
        
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName2)
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        deleteRequest2.resultType = .resultTypeObjectIDs
        let batchDelete2 = try! moc.execute(deleteRequest2) as? NSBatchDeleteResult
        guard let deleteResult2 = batchDelete2?.result as? [NSManagedObjectID] else { return }
        let deletedObjects2: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult2]
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects2,
            into: [moc]
        )
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//        .listRowSeparator(.hidden)
//        .background(Color.clear)
//    .onAppear {
//        UITableView.appearance().backgroundColor = UIColor.clear
//        UITableViewCell.appearance().backgroundColor = UIColor.clear
//    }
