### Q1. Write a Swift struct that conforms to the `Comparable` protocol and explain its significance.


In Swift, the **`Comparable` protocol guarantees that a specific data type can be evaluated using relational operators, such as `<` or `>`**. 

**Its Significance**
Conforming to `Comparable` is highly significant because it unlocks the ability to sort collections of your custom types or evaluate them using generic algorithms. For example, the sources illustrate a generic `findMax` function that can find the maximum value in any array, regardless of the data type. This is only possible because the generic placeholder is constrained to the `Comparable` protocol (`func findMax<T: Comparable>(_ array: [T])`), which promises the compiler that it is safe to check if one element is greater than another.

**Example: A `Comparable` Struct**
To make a custom struct conform to `Comparable`, you declare the conformance and implement the static `<` operator function to define exactly *how* two instances should be measured against one another.

```swift
// 1. Define a struct that conforms to the Comparable protocol
struct PlayerScore: Comparable {
    let playerName: String
    let points: Int
    
    // 2. Implement the required '<' operator
    // 'lhs' stands for Left Hand Side, 'rhs' stands for Right Hand Side
    static func < (lhs: PlayerScore, rhs: PlayerScore) -> Bool {
        // We dictate that players are compared solely by their points
        return lhs.points < rhs.points
    }
}

let player1 = PlayerScore(playerName: "Luke", points: 400)
let player2 = PlayerScore(playerName: "Cheryl", points: 800)

// 3. Because the struct is Comparable, we can use the '<' operator directly
if player1 < player2 {
    print("\(player2.playerName) has a higher score.") 
    // Outputs: Cheryl has a higher score.
}

// 4. We can also now use built-in array methods like .sorted() or .max()
let scores = [player2, player1]
let sortedScores = scores.sorted() 
```

### Q2. How would you write JSON data to a file and read it back in Swift?

To work with JSON data in Swift, your custom data types must first conform to the **`Codable` protocol**, which combines both the `Encodable` and `Decodable` protocols. Conforming to this protocol allows your types to be easily serialized and deserialized without having to manually write the underlying conversion logic. 

You use the **`JSONEncoder`** class to serialize your Swift object into JSON `Data`, and you use the **`JSONDecoder`** class to deserialize JSON `Data` back into a Swift object. Because encoding and decoding can produce errors, these methods must be called using the `try` keyword.


### Code Example: Writing and Reading JSON

```swift
import Foundation

// 1. Create a data type that conforms to the Codable protocol
struct Car: Codable {
    let make: String
    let model: String
    let year: Int
    let color: String
}

// Create an instance of your custom type
let myCar = Car(make: "Toyota", model: "Camry", year: 2020, color: "Silver")

// Create a file path to save the data
let fileManager = FileManager.default
let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
let fileURL = documentDirectory.appendingPathComponent("carData.json")


// 2. WRITE JSON TO A FILE
// Wrap throwing functions in a do-catch block to handle errors
do {
    // Initialize the encoder and encode the object into JSON data
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(myCar)
    
    // Write the data to the local file URL
    try jsonData.write(to: fileURL)
    print("Successfully wrote JSON to file.")
    
} catch {
    print("Failed to write JSON: \(error)")
}


// 3. READ JSON FROM A FILE
do {
    // Retrieve the raw data from the local file URL
    let savedData = try Data(contentsOf: fileURL)
    
    // Initialize the decoder and decode the data back into a Car object
    let decoder = JSONDecoder()
    let decodedCar = try decoder.decode(Car.self, from: savedData)
    
    print("Successfully read from file:")
    print(decodedCar) 
    // Output: Car(make: "Toyota", model: "Camry", year: 2020, color: "Silver")
    
} catch {
    print("Failed to read JSON: \(error)")
}
```

### Q3. How does `RawRepresentable` protocol help in working with enums? Write an enum conforming to it.


### What is `RawRepresentable`?
In Swift, **`RawRepresentable`** is a protocol that allows a custom data type—most commonly an `enum`—to be easily converted to and from a primitive "raw" underlying value, such as a `String`, `Int`, or `Double`. 

### How it Helps
When working with enums, conforming to `RawRepresentable` provides two major practical benefits:
1.  **Safe Initialization:** It automatically generates a failable initializer (`init?(rawValue:)`). This allows you to attempt to create an enum instance from raw data (such as a number saved in a database or a string parsed from a JSON API). If the raw value does not match any of the enum's predefined cases, the initializer safely returns `nil` instead of crashing your program. 
2.  **Value Extraction:** It provides a `rawValue` property, allowing you to quickly extract the underlying primitive value from an enum case when you need to pass it outside of your Swift code.

### Example
In Swift, you do not usually have to write out the full protocol conformance manually. By simply declaring an enum with a specific underlying primitive type, Swift implicitly makes it conform to the `RawRepresentable` protocol.

```swift
// By assigning an underlying raw type of 'String', this enum automatically 
// conforms to the RawRepresentable protocol.
enum NetworkStatus: String {
    case success = "OK"
    case unauthorized = "401_UNAUTHORIZED"
    case notFound = "404_NOT_FOUND"
}

// 1. Using the 'rawValue' property to extract the underlying string
let currentStatus = NetworkStatus.success
print("The raw value is \(currentStatus.rawValue)") 
// Output: The raw value is OK

// 2. Using the failable initializer to safely convert a raw string into an enum
let incomingResponse = "404_NOT_FOUND"

if let parsedStatus = NetworkStatus(rawValue: incomingResponse) {
    print("Status recognized: \(parsedStatus)") 
    // Output: Status recognized: notFound
} else {
    print("Unknown status code.")
}
```

### Q4. Describe how operators can be treated as functions in Swift. Provide an example explaining the concept.


In Swift, operators such as `+`, `-`, and `<` are not just mathematical symbols; they are actually **built-in functions** under the hood. They take input parameters (the values on the left and right sides of the symbol) and return a result. 

We saw a glimpse of this in our earlier conversation about the `Comparable` protocol, where you define exactly how the `<` operator works for a custom type by writing it as a standard static function: `static func < (lhs: PlayerScore, rhs: PlayerScore) -> Bool`.

Because operators are technically just functions, **you can pass an operator directly into any method that expects a function or closure**, provided the operator's input and output types match what the method requires.

### Example: Treating an Operator as a Function

The sources mention that you can take an unordered collection (like a `Set`) and order its elements into an array "using the `<` operator". 

Normally, if you wanted to sort an array of numbers, you might write a full closure. As the sources show, closures can be written out fully or shortened using implicit arguments like `$0` and `$1`. 

```swift
let numbers =

// 1. Using a standard closure
let sorted1 = numbers.sorted(by: { a, b in 
    return a < b 
})

// 2. Using a shortened closure expression
let sorted2 = numbers.sorted(by: { $0 < $1 })
```

However, the `.sorted(by:)` method simply expects a function that takes two parameters of the same type and returns a `Bool`. Because the `<` operator is already a Swift function that does exactly this, you don't need to wrap it in a closure at all. You can pass the operator symbol directly as if it were a function name:

```swift
// 3. Treating the operator as a function
let sorted3 = numbers.sorted(by: <)
```

By treating the `<` operator as a function, you drastically reduce the amount of code required while keeping the logic highly readable. This same concept applies to other functions like `.reduce()`, where you could pass the `+` operator as a function to easily add an array of numbers together.