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
    
    
//    func formatedDate(registeredDate: String) -> String {
//        let str = registeredDate
//        let formatter = ISO8601DateFormatter()
//        formatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone]
//        let date = formatter.date(from: str)
//        var sd = formatter.string(from: Date.now)
//        return sd
//
////        let dateFormatter = DateFormatter()
////
////        dateFormatter.dateFormat = "yyyy-MM-dd"
////
////        let updatedAtStr = registeredDate
////        let updatedAt = dateFormatter.date(from: updatedAtStr)
////        return updatedAtStr
//    }
    
        
    
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
