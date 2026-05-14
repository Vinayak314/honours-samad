### Q1. What is the purpose of the `throws` keyword in Swift functions? Provide a throwing function.

In Swift, the **`throws` keyword is used to indicate that a function can produce or throw an error**. By marking a function with `throws`, you allow it to propagate any errors it encounters up to the caller, rather than forcing the function to handle the error internally. 

Inside the throwing function, you use the **`throw`** statement to trigger a specific error (typically defined by an enumeration that conforms to the `Error` protocol) when a specific failure condition is met. 

Here is an example of a throwing function that throws an error if a user attempts to divide by zero:

```swift
// 1. Create an enum representing the error
enum DivisionError: Error {
    case dividedByZero
}

// 2. Create the throwing function using the 'throws' keyword
func division(numerator: Int, denominator: Int) throws {
    // 3. Use the 'throw' statement to trigger the error if the condition is met
    if denominator == 0 {
        throw DivisionError.dividedByZero
    }
    
    // ... continue with the division logic if no error is thrown
}
```

Whenever you call a function that has been marked with `throws`, you must acknowledge that it can fail by using the `try` keyword (e.g., `try division(numerator: 10, denominator: 0)`). As discussed previously, you will typically wrap this call in a `do-catch` block to gracefully handle the error if it is thrown.

### Q2. What are variadic parameters? Illustrate their usage in a function.

A **variadic parameter** allows a function to accept **zero or more values of a specific type**. You use a variadic parameter when you do not know exactly how many input values will be passed into the function when it is called. 

You create a variadic parameter by appending three periods (`...`) immediately after the parameter's data type. Inside the function body, Swift automatically converts the multiple values passed into that parameter into a standard **Array** of that type. 

### Example: A function calculating an average
Here is an example of a function that uses a variadic parameter to calculate the mathematical average of any number of test scores:

```swift
// The parameter 'scores' is defined as a variadic parameter using Double...
func calculateAverage(for scores: Double...) -> Double {
    var total: Double = 0
    
    // Inside the function, 'scores' is treated as a standard array: [Double]
    for score in scores {
        total += score
    }
    
    // Safely prevent dividing by zero if no arguments were passed
    if scores.isEmpty {
        return 0
    }
    
    return total / Double(scores.count)
}

// You can pass any number of comma-separated Double values into the function
let average1 = calculateAverage(for: 85.5, 92.0, 78.5, 100.0) 
print("First Average: \(average1)") // Outputs: First Average: 89.0

let average2 = calculateAverage(for: 10.0, 20.0)
print("Second Average: \(average2)") // Outputs: Second Average: 15.0

// You can even pass zero values
let average3 = calculateAverage()
print("Third Average: \(average3)") // Outputs: Third Average: 0.0
```

### Q3. What is a protocol in Swift? Write an example showing a class conforming to a protocol.

As previously discussed, a **protocol** acts as a blueprint of required properties and methods that a data type—such as a class, structure, or enumeration—can adopt. 

When a type conforms to a protocol, it guarantees that it has the capabilities defined by that blueprint. For example, conforming to Swift's built-in `Codable` protocol allows a custom data type to be easily serialized and deserialized to and from external representations like JSON without manually writing the encoding logic. Similarly, conforming to the `Error` protocol allows a type to represent unexpected errors during program execution. Protocols can even use **associated types** to declare placeholder names for types that are specified later when the protocol is actually adopted.

Here is an example from the sources demonstrating a custom protocol named `Printable`, and a `Car` class that conforms to it:

```swift
// 1. Define the protocol blueprint
protocol Printable {
    func printDescription()
}

// 2. Define a base class
class Vehicle {
    var manufacturer: String
    
    init(manufacturer: String) {
        self.manufacturer = manufacturer
    }
}

// 3. Create a subclass that inherits from Vehicle and conforms to Printable
class Car: Vehicle, Printable {
    var model: String
    
    init(manufacturer: String, model: String) {
        self.model = model
        super.init(manufacturer: manufacturer)
    }
    
    // 4. Implement the required protocol method
    func printDescription() {
        print("Car: \(manufacturer), \(model)")
    }
}

// 5. Use the conforming class
let myCar = Car(manufacturer: "Tesla", model: "Model 3")
myCar.printDescription() 
// Output: Car: Tesla, Model 3
```

### Q4. Write a Swift class that inherits from a generic class. Explain the use case.

Here is how you can write a Swift class that inherits from a generic class:

```swift
// 1. Define a generic base class
class Information<T> {
    // T acts as a placeholder for a type to be provided later
    var data: T
    
    init (data: T) {
        self.data = data
    }
    
    func getData() -> T {
        return self.data
    }
}

// 2. Define a subclass that inherits from the generic base class
class DetailedInformation<T>: Information<T> {
    var detailMessage: String
    
    init(data: T, detailMessage: String) {
        self.detailMessage = detailMessage
        // Call the superclass's initializer
        super.init(data: data)
    }
    
    func printDetails() {
        print("Detail: \(detailMessage), Data: \(getData())")
    }
}

// 3. Initialize the subclass
let stringInfo = DetailedInformation<String>(data: "Swift", detailMessage: "Programming Language")
stringInfo.printDetails() 
// Output: Detail: Programming Language, Data: Swift
```

### Explanation and Use Case

**The Purpose of Generics:** In Swift, generics allow you to create a single class that can be used with different data types, meaning you do not have to rewrite the same class for `Int`, `String`, or `Double`. By using a type parameter like `<T>`, you create a placeholder that tells Swift the exact data type will be defined later at runtime. This heavily promotes code reuse. 

**The Purpose of Inheritance:** Inheritance allows a new subclass to inherit the properties, methods, and initializers of an existing superclass. A subclass can then add its own unique properties, or override the superclass's methods to customize its behavior. 

**The Use Case:** Inheriting from a generic class is highly useful **when you want to build upon a highly reusable, foundational data structure without rewriting its core logic.** 
For example, the base `Information<T>` class manages the basic storage and retrieval of any data type. By creating the `DetailedInformation<T>` subclass, you inherit all of that core functionality for free, but you can extend the class to include additional metadata (like a `detailMessage`) or specific formatting methods needed for a particular feature in your app. This allows you to keep your base generic classes clean and versatile, while handling specific business logic in your subclasses.


### Q5. What is the `OptionSet` protocol in Swift? Describe with a use case. How does `OptionSet` differ from `enum` in Swift?

### What is the `OptionSet` Protocol?
In Swift, **`OptionSet`** is a protocol used to represent a set of options where **multiple options can be selected or active at the exact same time**. 

Under the hood, an `OptionSet` relies on bitwise operations (bitmasking). Each option is assigned a unique `rawValue` that is a power of 2 (1, 2, 4, 8, 16, etc.). Because each value occupies a different bit in memory, Swift can add them together into a single integer without the values overlapping or confusing one another.

### A Real-World Use Case: Text Formatting
Imagine you are building a text editor. A user might want a word to be bold, or italic, or **both bold and italic at the same time**. `OptionSet` is perfect for this.

```swift
struct TextFormat: OptionSet {
    let rawValue: Int

    // Each option is assigned a power of 2 using bitwise shift operators
    static let bold      = TextFormat(rawValue: 1 << 0) // 1
    static let italic    = TextFormat(rawValue: 1 << 1) // 2
    static let underline = TextFormat(rawValue: 1 << 2) // 4
    static let strikethrough = TextFormat(rawValue: 1 << 3) // 8
}

// You can combine multiple options using array literal syntax
var myTextStyle: TextFormat = [.bold, .italic]

// You can easily check if a specific option is included
if myTextStyle.contains(.bold) {
    print("The text is bold.")
}

// You can insert or remove options dynamically
myTextStyle.insert(.underline)
```

### How `OptionSet` Differs from `enum`
Based on the sources, an **`enum` (enumeration)** defines a common type for a group of related values, but **an `enum` instance can only hold one mutually exclusive case at a time**. 

For example, if you define an `enum CompassPoint { case north, east, south, west }`, a variable can be `.north` or `.east`, but it cannot be both at the same time. You use a `switch` statement to evaluate exactly which single state the enum is in.

**The Key Differences:**
*   **Combinations:** Use an `OptionSet` when a variable needs to hold a combination of multiple options simultaneously (like a pizza with multiple toppings). Use an `enum` when a variable must only ever be one specific thing at a time (like a movie's genre).
*   **Structure:** An `enum` is its own distinct data structure declared with the `enum` keyword. An `OptionSet` is typically declared as a `struct` that conforms to the `OptionSet` protocol and requires an integer `rawValue`. 
*   **Set Mathematics:** Because `OptionSet` conforms to Swift's set protocols, you get built-in mathematical set operations for free, such as `.contains()`, `.insert()`, `.intersection()`, and `.union()`. Enums do not have these capabilities.

### Q6. Describe the difference between `Decodable`, `Encodable`, and `Codable`.

In Swift, **`Codable` is simply a combination or union of the `Encodable` and `Decodable` protocols**. 

*   **`Encodable`**: This protocol **allows custom data types to be serialized or encoded** into an external representation, such as JSON. You use the `JSONEncoder` class to convert an object into JSON data so it can be easily saved for storage or transmitted over a network.
*   **`Decodable`**: This protocol **allows an external representation to be deserialized or decoded** back into a usable Swift object. You use the `JSONDecoder` class to convert incoming JSON data back into your custom data structures.
*   **`Codable`**: By adopting this single protocol, **your data type automatically conforms to both `Encodable` and `Decodable`** simultaneously. This grants your type the ability to easily be both written to and read from external formats without having to manually write the underlying encoding and decoding logic.
