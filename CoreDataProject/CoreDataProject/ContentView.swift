//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Omar Khattab on 09/09/2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var attributeName = "lastName"
    @State private var filterType = "BEGINSWITH"
    @State private var attributeValue = "S"
    

    var attributeNames = ["firstName","lastName"]
    var filterTypes = ["BEGINSWITH","CONTAINS[c]"]
    

    var body: some View {
        VStack {
            // list of matching singers

            FilteredList(attributeName: attributeName, filterType: filterType, attributeValue: attributeValue,
                         sortDescriptors: [SortDescriptor(\.firstName)])
            
            HStack{
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                if moc.hasChanges{
                try? moc.save()
                }
            }
                
                Spacer()
                Button("Delete Examples"){
                    delete(entityName: "Singer")
                }
                
            }.padding(.horizontal)
            HStack{
                Text("Please choose attribute name")
                Spacer()
                Picker("Please choose Attribute Name", selection: $attributeName) {
                    ForEach(attributeNames, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
            }.padding(.horizontal)
            
            HStack{
                Text("Please choose filter type")
                Spacer()
                Picker("Please choose Filter Type", selection: $filterType) {
                    ForEach(filterTypes, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
            }.padding(.horizontal)
            
            
            
            TextField("Enter Filter Value",text: $attributeValue)
                .padding()
        }
    }
    
    func delete(entityName: String) {
    
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        let batchDelete = try! moc.execute(deleteRequest) as? NSBatchDeleteResult
        guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }
        let deletedObjects: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult]
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [moc]
        )
        
        
        
        
//
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Singer")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        deleteRequest.resultType = .resultTypeObjectIDs
//        let result = try! moc.execute(deleteRequest) as! NSBatchDeleteRequest
//        let chenges: [AnyHashable: Any] = [
//            NSDeletedObjectsKey: result.result as! [NSManagedObjectID]
//        ]
//        try moc.mergeChanges(fromContextDidSave: chenges, into:[moc])
//
//        do {
////                        try DataController.execute(deleteRequest, with: moc)
//            try moc.execute(deleteRequest)
//            try moc.save()
//
//
//        } catch let error as NSError {
//            print (error.localizedDescription)
//        }
//
//
        
        
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        do {
//            try moc.execute(deleteRequest)
//            try moc.save()
//        } catch let error as NSError {
//            debugPrint(error.localizedDescription)
//        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
