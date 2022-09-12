//
//  ContentView.swift
//  Bookworm
//
//  Created by Omar Khattab on 05/09/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
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
                
                
                VStack{
                    Text("")
                        .frame(width: 0, height: 0, alignment: .center)
                        .foregroundColor(.clear)
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            DetailView(book: book)
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                    
                                
                                VStack(alignment: .leading) {
                                    Text(book.title ?? "Unknown Title")
                                        .font(Font.custom("Gaegu-Bold", size: 30))
                                        .foregroundColor(book.rating < 2 ? .yellow : .black)
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }.onDelete(perform: deleteBooks)
                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
                }.onAppear(){
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
                }
            }// zstak end
            .preferredColorScheme(.light)
//            .navigationAppearance(backgroundColor: .clear, foregroundColor: .black, tintColor: .black, hideSeparator: true)
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
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
        }.accentColor(.black)
    
    }
    init(){
            for family: String in UIFont.familyNames {
                print(family)
                for names: String in UIFont.fontNames(forFamilyName: family) {
                    print("== \(names)")
                }
            }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
