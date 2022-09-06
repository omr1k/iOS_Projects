//
//  ContentView.swift
//  Bookworm
//
//  Created by Omar Khattab on 05/09/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    static let color0 = Color(red: 227/255, green: 76/255, blue: 227/255);
    static let color1 = Color(red: 0/255, green: 209/255, blue: 255/255);
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
                
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            Text(book.title ?? "Unknown Title")
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }.listRowBackground(LinearGradient(
                        gradient: gradient,
                        startPoint: .init(x: 0.00, y: 0.50),
                        endPoint: .init(x: 1.00, y: 0.50)
                      ))
                }.onAppear(){
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
            }// zstak end
               .navigationTitle("Bookworm")
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button {
                           showingAddScreen.toggle()
                       } label: {
                           Label("Add Book", systemImage: "plus").foregroundColor(.black)
                       }
                   }
               }
               .sheet(isPresented: $showingAddScreen) {
                   AddBookView()
               }
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
