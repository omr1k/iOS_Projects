//
//  DetailView.swift
//  FriendFace
//
//  Created by Omar Khattab on 11/09/2022.
//

import SwiftUI

struct DetailView: View {
    var userToShow : User
    
    var body: some View {
        Text(userToShow.name)
        Text("\(userToShow.age)")
        Text(userToShow.company)
        Text(userToShow.email)
        Text(userToShow.address)
        Text(userToShow.registered)
        Image(systemName: "circle.fill")
            .foregroundColor(userToShow.isActive ? .green : .red)
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
