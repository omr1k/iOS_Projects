//
//  ContentView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 07/10/2022.
//

import SwiftUI

struct ContentView: View {

    @State private var showAddView = false
    @ObservedObject var savedPersonDate = SavePersonData()
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(0..<savedPersonDate.persons.count, id: \.self) { index in
                        HStack{
                            
                            if let image = ImageUtils().loadImageFromDiskWith(fileName: savedPersonDate.persons[index].imageFilename) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(25)
                                    // for placeholders
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                            Text(savedPersonDate.persons[index].name)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    } // foreach end
                }// list end
            }
            .sheet(isPresented: $showAddView){
                AddView(SavePersonData: savedPersonDate)
            }
            .navigationTitle("Never Forget")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        print("Plus icon pressed...")
                        showAddView = true
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


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
