//
//  AddBookView.swift
//  Bookworm
//
//  Created by Omar Khattab on 06/09/2022.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var showingAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
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
                
                
                Form {
                    Section {
                        
                        TextField("Name of book", text: $title)
                        
                        TextField("Author's name", text: $author)
                        
                        VStack{
                        Text("Choose a genre")
                        
                        Picker("Genre", selection: $genre) {
                            ForEach(genres, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.automatic)
                                .listRowBackground(Color.clear)
                        }
                            
                        
                        
                        
                    }.listRowBackground(Color.clear)
                    
                    Section {
                        TextEditor(text: $review)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
                            )
                        
                        //                    Picker("Rating", selection: $rating) {
                        //                        ForEach(0..<6) {
                        //                            Text(String($0))
                        //                        }
                        //                    }
                        VStack{
                            Spacer()
                            HStack{
                            Spacer()
                            RatingView(rating: $rating)
                                    .font(.largeTitle)
                                Spacer()
                            }
                            Spacer()
                        }.overlay(
                            RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
                        )
                        
                    }header: {
                        Text("Write a review")
                            .fontWeight(.bold)
                    }.listRowBackground(Color.clear)
                    
                    
                    Section {
                        HStack{
                            Spacer()
                            Button("Save") {
                                
                                if title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty {
                                    showingAlert.toggle()
                                }else{
                                    let newBook = Book(context: moc)
                                    newBook.id = UUID()
                                    newBook.title = title
                                    newBook.author = author
                                    newBook.rating = Int16(rating)
                                    newBook.genre = genre
                                    newBook.review = review
                                    newBook.date = Date.now
                                    
                                    
                                    try? moc.save()
                                    dismiss()
                                }
                                
                                
                            }
                            .foregroundColor(.black)
                            .tint(.white)
                            .buttonStyle(.borderedProminent)
                            Spacer()
                            
                            Button("Cancel"){
                                dismiss()
                            }.foregroundColor(.black)
                                .tint(.white)
                                .buttonStyle(.borderedProminent)
                            
                            Spacer()
                        }
                        
                    }.listRowBackground(Color.clear)
                }
            }// zstack end
            .navigationTitle("Add Book")
        }
        
        .alert("Error!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please Enter All Book Info")
        }
        
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
