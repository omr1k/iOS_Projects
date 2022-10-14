//
//  ContentView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 07/10/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [ SortDescriptor(\.name)]) var persons: FetchedResults<Person>

    @State private var showAddView = false

    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(persons) { person in
                        NavigationLink(destination: DetailsView(person: [person], imgeFileName: person.wrappedimageFilename, imgePath: person.imageAbslutePath ?? "", personName: person.wrappedName)){
                            HStack{
                                if let image = ImageUtils().loadImageFromDiskWith(fileName: person.wrappedimageFilename) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(25)
                                    // for placeholders
                                        .foregroundColor(Color.gray)
                                }
                                
//                                Text("\(index)")
//                                Text("\(person.latitude)")
//                                Text("\(person.longitude)")
                                
                                Text(person.wrappedName)
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                                Spacer()
                            }// hstack end
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        
                    }.onDelete(perform: deleteRecord2)// foreach end
                }// list end
            }
            .sheet(isPresented: $showAddView){
                AddView()
            }
            .navigationTitle("Never Forget")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        showAddView = true
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }
            )
        }
    }
    
    
    func deleteRecord2(at offsets: IndexSet) {
        
        for offset in offsets {
            // find this book in our fetch request
            let person = persons[offset]
            // delete it from the context
            moc.delete(person)
            ImageUtils().deleteFromDocuments(imageFileName: "\(person.wrappedimageFilename)")
        }
        // save the context
        try? moc.save()
    }
}

























//    @ObservedObject var savedPersonData = SavePersonData()
//    @StateObject var savedPersonData = SavePersonData()

    
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


//VStack(alignment: .leading, spacing: 10) {
//    //Populate text with info from notification.
//
//    if let image = ImageUtils().loadImageFromDiskWith(fileName: "8832F886-F75F-41AA-B718-A79AFA60E4FB") {
//        Image(uiImage: image)
//            .resizable()
//            .scaledToFit()
//    } else {
//       // Put some placeholder image here
//    }
//}







//    func deleteRecord(at offsets: IndexSet) {
//        savedPersonData.persons.remove(atOffsets: offsets)
//        print(offsets)
////        let vaar = savedPersonData.persons[0].imageFilename
////        print("vaar \(vaar)")
////        ImageUtils().deleteFromDocuments(imageFileName: savedPersonData.persons[0].imageFilename)
//        offsets.forEach { (index) in
//            print("normal \(index)")
//            print("-1 === \(index+1)")
////            ImageUtils().deleteFromDocuments(imageFileName: savedPersonData.persons[index+1].imageFilename)
//            if savedPersonData.persons.indices.contains(1) {
//                print(savedPersonData.persons[1].imageFilename)
//
////                ImageUtils().deleteFromDocuments(imageFileName: savedPersonData.persons[index-1].imageFilename)
//            }else{
//                print("not found")
//            }
//
//            //            print(index)
//            //
//            //        }
//
//            //        offsets.forEach { (index) in
//            //            ImageUtils().deleteFromDocuments(index: index)
//            //            print(index)
//            //            let x = savedPersonData.persons[index-1].imageFilename
//            //
//            //            print(x)
//            //        }
//
//            //        if savedPersonData.persons.indices.contains(0) {
//            //           print(savedPersonData.persons[0])
//            //        }
//
//            //        ImageUtils().deleteFromDocuments(fileName: <#T##String#>)
//            //        var arrayOfInts = [Int]()
//            //        arrayOfInts =
//            //
//
//
//            //        offsets.forEach { (index1) in
//            //            savedPersonDate.delete(index: index1)
//            //        }
//            //        savedPersonDate.persons.
//            //        print(offsets)
//            //        offsets.forEach { (index1) in
//            //            print("\(savedPersonDate.persons[1].imageFilename)")
//            //            ImageUtils().deleteFromDocuments(fileName: savedPersonDate.persons[index1].imageFilename)
//
//            //        offsets.map { savedPersonDate.persons[$0].imageFilename }.forEach { index in
//            //            ImageUtils().deleteFromDocuments(fileName: savedPersonDate.persons.imageFilename)
//            //        }
//
//            //        var index = Int(offsets) ?? 0
//            //        ImageUtils().deleteFromDocuments(fileName: "\(savedPersonDate.persons[index].imageFilename)")
//
//            //        ImageUtils().deleteFromDocuments(fileName: savedPersonDate.persons[index].imageFilename)
//
//
//
//            //        print("\(savedPersonDate.persons)")
//
//            //        countt.forEach { (indexx) in
//            //            print("222222\(indexx)")
//            //            print("\(savedPersonDate.persons[indexx].imageFilename)")
//            ////            ImageUtils().deleteFromDocuments(fileName: savedPersonDate.persons[indexx].imageFilename)
//            //        }
//
//        } // delete method end
//    }
