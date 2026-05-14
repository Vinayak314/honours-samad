# Set 6

## Question 1
- Create a User class with optional email and phoneNumber properties.
- Write a method displayContactInfo() that uses guard let and if let to unwrap values.
- If values are missing, provide default messages using the ?? Operator.
- Also include a required name property and use guard to ensure it's not empty.
- Demonstrate with different user objects: full info, partial info, and empty name.

### Code
```swift
class User {
    var name: String
    var email: String?
    var phoneNumber: String?
    
    init(name: String, email: String? = nil, phoneNumber: String? = nil) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    func displayContactInfo() {
        // Guard to ensure name is not empty
        guard !name.isEmpty else {
            print("Error: User must have a valid name.")
            return
        }
        
        print("--- Contact Info for \(name) ---")
        
        // Using if let to unwrap email
        if let unwrappedEmail = email {
            print("Email: \(unwrappedEmail)")
        } else {
            // Using ?? operator for default message (redundant with else, but showing usage)
            print("Email: \(email ?? "Not provided")")
        }
        
        // Using guard let to unwrap phone number
        guard let unwrappedPhone = phoneNumber else {
            // Using ?? operator for default message
            print("Phone: \(phoneNumber ?? "Not provided")")
            return
        }
        print("Phone: \(unwrappedPhone)")
    }
}

// Demonstration
let userFullInfo = User(name: "Alice", email: "alice@example.com", phoneNumber: "555-1234")
let userPartialInfo = User(name: "Bob", email: "bob@example.com", phoneNumber: nil)
let userEmptyName = User(name: "", email: nil, phoneNumber: nil)

userFullInfo.displayContactInfo()
print()
userPartialInfo.displayContactInfo()
print()
userEmptyName.displayContactInfo()
```

## Question 2
A digital library recommends books based on the number of times they've been read.
Requirements:
- Create a class Book with properties title, author, and readCount (with didSet to print a message when updated).
- Store multiple Book objects in an array.
- Write a function that accepts a closure and returns all books read more than a certain number of times.
- Demonstrate using that closure to get recommended books.

### Code
```swift
class Book {
    var title: String
    var author: String
    var readCount: Int {
        didSet {
            print("'\(title)' read count updated from \(oldValue) to \(readCount)")
        }
    }
    
    init(title: String, author: String, readCount: Int = 0) {
        self.title = title
        self.author = author
        self.readCount = readCount
    }
}

// Store multiple Book objects in an array
var library: [Book] = [
    Book(title: "1984", author: "George Orwell", readCount: 15),
    Book(title: "The Hobbit", author: "J.R.R. Tolkien", readCount: 50),
    Book(title: "Dune", author: "Frank Herbert", readCount: 5)
]

// Function that accepts a closure
func getRecommendedBooks(from books: [Book], criteria: (Book) -> Bool) -> [Book] {
    return books.filter(criteria)
}

// Demonstrate updating read count to trigger didSet
library[2].readCount = 12

print("\n--- Recommended Books ---")

// Closure to filter books read more than 10 times
let popularBooksClosure: (Book) -> Bool = { book in
    return book.readCount > 10
}

let recommended = getRecommendedBooks(from: library, criteria: popularBooksClosure)

for book in recommended {
    print("\(book.title) by \(book.author) (Reads: \(book.readCount))")
}
```
