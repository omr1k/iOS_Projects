//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Omar Khattab on 09/09/2022.
//

import SwiftUI

struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                
        }
    }
    
    init(attributeName:String, filterType:String, attributeValue:String, sortDescriptors: [SortDescriptor<Singer>]) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: sortDescriptors,
                                             predicate: NSPredicate(format: "%K \(filterType) %@", attributeName,attributeValue))
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
