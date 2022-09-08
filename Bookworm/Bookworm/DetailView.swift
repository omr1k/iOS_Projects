//
//  DetailView.swift
//  Bookworm
//
//  Created by Omar Khattab on 06/09/2022.
//

import CoreData
import SwiftUI


struct DetailView: View {
    let book: Book
    static let color0 = Color(red: 227/255, green: 76/255, blue: 227/255);
    static let color1 = Color(red: 0/255, green: 209/255, blue: 255/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(
                    gradient: gradient,
                    startPoint: .init(x: 0.00, y: 0.50),
                    endPoint: .init(x: 1.00, y: 0.50)
                ))
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre ?? "Fantasy")
                        .resizable()
                        .scaledToFit()
                    
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                HStack{
                    Spacer()
                    Text("Author:")
                        .font(.title)
                        .foregroundColor(.secondary)
                    
                    Text(book.author ?? "Unknown author")
                        .font(.title)
                        .foregroundColor(.secondary)
                    Spacer()
                }
               
                    
                Divider()
                Text("Book Review 👇🏼")
                    .foregroundColor(.secondary)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text(book.review ?? "No review")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                Divider()
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
                Divider()
                Text("Record Created on \(self.formatedDate())")
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
            }
            .navigationTitle(book.title ?? "Unknown Book")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Delete book", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteBook)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure?")
            }
            .toolbar {
                Button {
                    showingDeleteAlert = true
                } label: {
                    Label("Delete this book", systemImage: "trash")
                }
            }
        } //zstack end
//        .navigationTitle(book.title ?? "Unknown Book")
//        .navigationBarTitleDisplayMode(.inline)
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
    
    func formatedDate() -> String {
        if let launchDate = book.date {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                return formatter.string(from: launchDate)
        }
        return "N/A"
    }
}



//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
