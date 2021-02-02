//
//  DetaiView.swift
//  BookCoreData
//
//  Created by Екатерина Чернова on 29.01.2021.
//
import CoreData
import SwiftUI

struct DetaiView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentetationMode
    @State private var showingDeleteAlert = false
    let book: Book
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth:geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "Fantasy")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown authoe")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                .font(.largeTitle)
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure OR NOT ?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
            }, secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        })
        {
            Image(systemName: "trash")
        }
        )
        }
    
    func deleteBook() {
        moc.delete(book)
        
        // try? self.moc.save()
        presentetationMode.wrappedValue.dismiss()
    }
}

struct DetaiView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "Хорошая книга"
        
        
        return NavigationView {
            DetaiView(book: book)
        }
       
        
        
    }
}
