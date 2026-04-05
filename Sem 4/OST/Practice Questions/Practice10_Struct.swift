// Problem Statement 10: Structs
// Represent a basic library book using a struct.

struct Book {
    var title: String
    var author: String
    var pages: Int
}

let myBook = Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", pages: 218)

print("'\(myBook.title)' by \(myBook.author) has \(myBook.pages) pages.")
