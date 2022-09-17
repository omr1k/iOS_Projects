//
//  DetailView.swift
//  FriendFace
//
//  Created by Omar Khattab on 17/09/2022.
//

import SwiftUI

struct DetailView: View {
    let userToShow : CachedUser
    
    static let color0 = Color(red: 240/255, green: 81/255, blue: 56/255);
    static let color1 = Color(red: 3/255, green: 169/255, blue: 244/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(
                    gradient: gradient,
                    startPoint: .init(x: 0.00, y: 0.50),
                    endPoint: .init(x: 1.00, y: 0.50)
                ))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(.secondary)
                
                HStack{
                    Spacer()
                    Text(userToShow.wrappedName)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Image(systemName: "circle.fill")
                        .foregroundColor(userToShow.isActive ? .green : .secondary)
                    Spacer()
                }
                
                
                List{
                    Section{
                        Text("Registered: \(userToShow.wrappedFormattedDate)").fontWeight(.semibold).foregroundColor(.white)
                        Text("Age: \(userToShow.age)").fontWeight(.semibold).foregroundColor(.white)
                        Text("Email: \(userToShow.wrappedEmail)").fontWeight(.semibold).foregroundColor(.white)
                        Text("Adress: \(userToShow.wrappedAddress)").fontWeight(.semibold).foregroundColor(.white)
                        Text("Company: \(userToShow.wrappedCompany)").fontWeight(.semibold).foregroundColor(.white)
                    } header: {
                        Text("Info")
                            .foregroundColor(.white)
                    }.listRowBackground(Color.clear)
                    
                    Section{
                        Text(userToShow.wrappedAbout)
                            .foregroundColor(.white)
                    } header: {
                        Text("About")
                            .foregroundColor(.white)
                    }.listRowBackground(Color.clear)
                    
                    Section{
                        ForEach(userToShow.friendsArray){ friend in
                            Text(friend.wrappedName).foregroundColor(.white)
                        }
                    }header: {
                        Text("Friends")
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.clear)
                }.scrollContentBackground(.hidden)
            }
        }
        
        
        .navigationTitle("Details")
        .foregroundColor(.black)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

