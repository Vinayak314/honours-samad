### Q1. Explain error handling in Swift? Describe the do-try-catch block with example
In Swift, an **error is an unexpected event** that occurs during program execution, which can cause the program to terminate abnormally. To manage these unexpected events predictably, Swift represents errors as values of types that conform to the **`Error` protocol**.

The standard error handling process in Swift involves four main steps:
1. **Create an Error Enum**: Define an enumeration that conforms to the `Error` protocol to represent the specific types of errors your program might encounter.
2. **Create a Throwing Function**: Add the `throws` keyword to a function's declaration to indicate it can produce an error. Inside the function, use the `throw` statement to trigger a specific error when a failure condition is met.
3. **Call with `try`**: Use the `try` keyword when calling the throwing function to acknowledge that it might fail.
4. **Handle Errors with `do-catch`**: Wrap the `try` code inside a `do` block and add a `catch` block to gracefully handle any errors that are thrown.

### **The `do-try-catch` Block**
The **`do-catch` statement allows you to handle errors in a controlled and predictable way**. You place the code that might fail (using `try`) inside the `do` block. If that code executes successfully, the program continues normally. However, if an error is thrown, the program immediately exits the `do` block and jumps to the `catch` block. 

By default, the `catch` block provides an `error` parameter that contains the thrown error. You can also use **pattern matching with multiple `catch` blocks** to catch specific error types and handle them differently depending on their value.

**Example:**
```swift
// 1. Create an enum that conforms to the Error protocol
enum SimpleError: Error {
    case somethingWentWrong
}

// 2. Create a throwing function using the 'throws' keyword
func doSomething() throws -> String { 
    if true { 
        // Throw the specific error
        throw SimpleError.somethingWentWrong 
    } 
    return "Success!" 
} 

// 3 & 4. Handle the error using a do-try-catch block
do {
    // The code that might fail is called with 'try' inside the 'do' block
    let result = try doSomething() 
    print(result)
} catch SimpleError.somethingWentWrong {
    // Catching a specific error type
    print("Something went wrong")
} catch let otherError {
    // Catching any other potential error
    print("Error: \(otherError)") 
}
```

### Q2. Explain type constraints in generics? Give an example
By default, generic type parameters can accept any data type, such as `Int`, `String`, or `Double`. **Type constraints** are used when you want to restrict a generic function or class to only accept specific types, ensuring that the types used have the required capabilities or conform to a certain protocol. You create a type constraint by placing a protocol or class name after the generic type parameter, separated by a colon.

### Basic Example
If you want to create an `addition` function using generics, the generic types must be numbers so they can be mathematically added. You can constrain the type parameter `T` so that it must conform to Swift's built-in `Numeric` protocol:

```swift
// Create a generic function with a Numeric type constraint
func addition<T: Numeric>(num1: T, num2: T) {
    print("Sum:", num1 + num2)
}

// You can now safely pass Int values
addition(num1: 5, num2: 10) // Output: Sum: 15

// Or pass Double values
addition(num1: 5.5, num2: 10.8) // Output: Sum: 16.3
```

### Advanced Type Constraints
Type constraints can also handle much more complex requirements:
*   **Class Constraints:** You can mandate that a generic type must be a specific class or inherit from a specific subclass.
*   **Composition Constraints:** You can require a generic type parameter to satisfy multiple constraints simultaneously, such as inheriting from a class *and* conforming to a protocol (e.g., `<T: Vehicle & Printable>`).
*   **Generic `where` Clauses:** A `where` clause provides fine-grained control over associated types. For example, if you are comparing two generic containers, you can use a `where` clause to ensure that both containers hold the exact same type of item (`where C1.Item == C2.Item`), and that the items can be compared for equality (`C1.Item: Equatable`).

### Q3. How do you access, add and update values in dictionary? Explain with example

In Swift, you can manage a dictionary's contents using its keys. Here is how you can add, update, and access values:

**Adding and Updating Values**
You can add or modify values directly using subscript syntax. By assigning a value to a specific key, Swift will either create a new key-value pair if the key does not exist, or update the existing value if the key is already present in the dictionary. 

Alternatively, you can use the **`updateValue(_:forKey:)`** method. This method updates the value for the specified key but **returns the old value** (as an optional) before the update occurred, which is helpful if you need to check or use the previous state.

**Accessing Values**
When you access a dictionary value using a key, Swift returns an **optional** because there is no guarantee that the key actually exists. You can safely unwrap and access this value using optional binding, such as the `if let` statements we discussed earlier. 

If you need to access every key or every value at once, you can pass the dictionary's `.keys` or `.values` properties into a new `Array`.

### Example

```swift
// Defining an initial dictionary
var scores = ["Richard": 500, "Luke": 400, "Cheryl": 800]

// 1. Adding a new value using a subscript
scores["Oli"] = 399

// 2. Updating a value using updateValue(_:forKey:)
if let oldValue = scores.updateValue(100, forKey: "Richard") {
    print("Richard's old value was \(oldValue)") 
    // Outputs: Richard's old value was 500
}

// 3. Accessing a specific value safely using if let
if let lukesScore = scores["Luke"] {
    print(lukesScore) 
    // Outputs: 400
}

// 4. Accessing all keys and all values as arrays
let players = Array(scores.keys)   // ["Richard", "Luke", "Cheryl", "Oli"]
let points = Array(scores.values)  //
```

### Q4. Compare and contrast the `for-in`, `while`, and `repeat-while` loops in Swift. Give examples to explain how and when to use each.
In Swift, **`for-in`**, **`while`**, and **`repeat-while`** loops are used to execute a block of code multiple times, but they differ in how they evaluate conditions and handle iterations. 

### **`for-in` Loops**
**How it works:** A `for-in` loop executes a set of statements for each item in a given sequence or collection.
**When to use it:** Use a `for-in` loop when you have a known number of items to iterate over, such as a range of numbers, elements in an array, characters in a string, or key-value pairs in a dictionary. 

**Examples:**
Iterating over an array of names:
```swift
let names = ["Joseph", "Cathy", "Winston"]
for name in names {
    print("Hello \(name)")
}
```

Iterating over a dictionary to access both keys and values:
```swift
let vehicles = ["unicycle" : 1, "bicycle" : 2, "tricycle" : 3]
for (vehicleName, wheelCount) in vehicles {
    print("A \(vehicleName) has \(wheelCount) wheels")
}
```

---

### **`while` Loops**
**How it works:** A `while` loop evaluates a condition *before* each pass through the loop. As long as the condition evaluates to `true`, the code block will continue to run. 
**When to use it:** Use a `while` loop when **the number of iterations is unknown in advance** and the loop should run until a specific condition changes dynamically. 

**Example:**
```swift
var numberOfLives = 3
var stillAlive = true

// The loop checks if stillAlive is true before running
while stillAlive {
    print("I still have \(numberOfLives) lives.")
    numberOfLives -= 1
    
    if numberOfLives == 0 {
        stillAlive = false // This will break the loop before the next check
    }
}
```

---

### **`repeat-while` Loops**

**How it works:** A `repeat-while` loop operates similarly to a `while` loop, but it evaluates its condition *after* the code block has executed, rather than before.
**When to use it:** Use a `repeat-while` loop when you need to ensure that the block of code **executes at least once**, regardless of the condition's initial state. 

**Example:**
```swift
var attempts = 5

repeat {
    print("Trying to connect... Attempt \(attempts)")
    attempts += 1
} while attempts < 3
```
In this example, even though `attempts` is already greater than 3, the code inside the `repeat` block will run once and print "Trying to connect... Attempt 5" before the loop checks the condition and terminates.

### Q5. Explain substring in Swift? Write code to extract a substring from a given string

Based on the sources, finding substrings involves checking if a string contains certain text using the **`.contains()`** method. For example, you can search for a specific phrase within a larger string:
```swift
let greeting = "Hi Rick, my name is Amy."
if greeting.contains("my name is") {
    print("Making an introduction")
}
```
The sources also note that you can evaluate substrings located specifically at the beginning or end of a string using **`.hasPrefix()`** and **`.hasSuffix()`**.

In Swift, when you extract a part of a string, it creates a special **`Substring`** type rather than a standard `String`. Substrings are highly memory-efficient because they **share the exact same memory** as the original string they were cut from. However, if you want to keep the extracted text around long-term, you must explicitly convert it back into a standard `String` so the original string's memory can be safely freed by the system.

Furthermore, Swift does not allow you to extract substrings using simple integer indexes (like `text[0...4]`). Because Swift strings are fully Unicode-compliant, different characters (like emojis or special symbols) require different amounts of memory. Instead, you must calculate positions using **`String.Index`**.

### Code Examples for Extracting Substrings

**1. Extracting with `.prefix()` and `.suffix()`**
The easiest way to extract a substring from the beginning or end of a string is using these built-in methods:
```swift
let originalString = "Hello, World!"

// Extract the first 5 characters
let firstWordSubstring = originalString.prefix(5) 
print(firstWordSubstring) // Outputs: "Hello"

// Extract the last 6 characters
let lastWordSubstring = originalString.suffix(6)
print(lastWordSubstring) // Outputs: "World!"
```

**2. Extracting using a specific range (`String.Index`)**
To extract a substring from the middle of a string, you calculate the starting and ending indices using the `index(_:offsetBy:)` method:
```swift
let text = "Hello, World!"

// Calculate the start index (7 characters from the beginning)
let startIndex = text.index(text.startIndex, offsetBy: 7)

// Calculate the end index (1 character from the end)
let endIndex = text.index(text.endIndex, offsetBy: -1)

// Extract the substring using a range
let middleSubstring = text[startIndex..<endIndex] 
print(middleSubstring) // Outputs: "World"
```

**3. Converting a Substring back to a String**
Because substrings share memory with the original string, you should convert them back to a standard `String` if you plan to store them for later use:
```swift
let permanentString = String(middleSubstring)
```

### Q6. Explain the significance of protocol oriented programming and how it is different from object oriented programming

**Protocol-Oriented Programming (POP)** and **Object-Oriented Programming (OOP)** are two different design paradigms. The sources outline the core mechanics of classes, structures, and protocols that illustrate how these paradigms operate in Swift.

### Object-Oriented Programming (OOP)
OOP is a traditional programming paradigm that relies heavily on **classes and inheritance** to share code and model behavior. 
*   **Inheritance Hierarchies:** In OOP, you create a base class (superclass) and define subclasses that inherit its properties, methods, and initializers. For example, a `Tandem` class can inherit from a `Bicycle` class, which inherits from a `Vehicle` class.
*   **Reference Types:** Classes are reference types, meaning that when you assign a class instance to multiple variables, they all point to the exact same memory address.
*   **Limitations:** Swift classes only support *single inheritance*, meaning a subclass can only inherit from one superclass. This can lead to bloated, rigid hierarchies where subclasses inherit functionality they don't actually need.

### Protocol-Oriented Programming (POP)
Apple introduced Swift as the world's first "Protocol-Oriented" language. Instead of relying on a rigid tree of superclasses and subclasses, POP focuses on designing **protocols**—blueprints of required properties and methods—that any data type can adopt. 

The significance of POP and its key differences from OOP include:

**1. Empowering Value Types**
OOP is restricted to classes. However, Apple recommends that developers **start new types as structures** and only use classes when specific features like inheritance or reference sharing are strictly required. POP makes this possible: because structs and enums do not support inheritance, protocols are the primary way to share capabilities and build modular architecture using these safe, memory-efficient value types. 

**2. Composition Over Inheritance (Multiple Conformance)**
While a class can only have one superclass, **any type in Swift can conform to multiple protocols simultaneously**. 
For example, the sources show a scenario where a generic type parameter `T` is constrained using composition to ensure it acts as both a `Vehicle` and something that is `Printable` (written as `<T: Vehicle & Printable>`). This allows you to mix and match modular capabilities rather than forcing an object into a single hierarchical family tree.

**3. Protocol Extensions**
The true power of POP comes from *Protocol Extensions*. In standard OOP, if you want objects to share the exact same implementation of a method, they must share a base class. In POP, you can write an extension for a protocol that provides a default implementation of a method. Any struct, enum, or class that adopts the protocol automatically gains that code, allowing you to share logic across completely unrelated types. 

**Summary**
Ultimately, **OOP** builds vertical, dependent relationships through class inheritance, while **POP** builds horizontal, decoupled relationships by sharing capabilities across unrelated types (including structs and enums) using protocols.

