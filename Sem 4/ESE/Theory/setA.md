### Q1. Compare structs and classes in Swift

| Feature | Structs | Classes |
| :--- | :--- | :--- |
| **Type Behavior** | Value types; when you assign an instance to multiple variables, each variable receives its own copied value, meaning updates to one do not affect the others. | Reference types; when you assign an instance to multiple variables, they all contain the same memory address and refer to the exact same instance. |
| **Inheritance** | Does not support inheritance. | Supports inheritance, allowing a subclass to inherit from a superclass and override its properties, methods, and initializers. |
| **Initializers** | Swift automatically provides memberwise initializers. | Swift does not create memberwise initializers automatically; developers must define their own. |
| **Mutating Methods** | If a method changes a property, it must be explicitly annotated with the `mutating` keyword. | The `mutating` keyword is not required for methods that change properties. |
| **When to Use** | It is recommended to start new types as structures. | Use classes when a framework requires them, when you need to refer to the exact same instance in multiple places, or when you need to model inheritance. |

### Q2. Explain Mutating methods in Swift with the help of an example

In Swift, if a method on a value type (such as a structure) changes one or more of its properties, the method must be explicitly annotated with the **`mutating`** keyword. This is an example of Swift's type safety features, as value types are typically immutable from within their own instance methods. 

It is important to note that **the `mutating` keyword is only required for value types like structs and not for classes**. 

### Example 1: An Odometer
Here is an example using an `Odometer` structure where methods increment or reset the mileage:

```swift
struct Odometer {
    var count: Int = 0 // Assigns a default value to the 'count' property.
    
    // The mutating keyword is required because 'count' is being modified
    mutating func increment() {
        count += 1
    }
    
    mutating func increment(by amount: Int) {
        count += amount
    }
    
    mutating func reset() {
        count = 0
    }
}
```
In this example, the `increment()`, `increment(by:)`, and `reset()` methods alter the internal `count` property, so they must be declared as `mutating`. 

You can then use these mutating methods to update the `Odometer` instance:
```swift
var odometer = Odometer() // odometer.count defaults to 0
odometer.increment() // odometer.count is incremented to 1
odometer.increment(by: 15) // odometer.count is incremented to 16
odometer.reset() // odometer.count is reset to 0
```

### Example 2: A Generic Stack
Another common use case shown in the sources is a custom `Stack` collection. Because a stack relies on adding ("pushing") and removing ("popping") items from its internal array, its methods must also be marked as mutating:

```swift
struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
```

### Q3. Explain optional binding using if let and guard let. Provide examples.

**Optional binding** is a safe way to check if an optional contains a value and, if so, unwrap it into a temporary constant or variable. In Swift, this is primarily done using **`if let`** and **`guard let`**. 

### **`if let`**
When you use `if let`, the system checks if the optional has a value. If it does, the unwrapped value is assigned to a constant, and that constant is **only accessible within the braces of the `if` block**. If the optional is `nil`, the code inside the block is skipped, and you can provide an `else` block to handle the `nil` case.

**Example:**
```swift
if let unwrappedPublicationYear = book.publicationYear {
    // unwrappedPublicationYear has been safely unwrapped for use within the braces.
    print("The book was published in \(unwrappedPublicationYear)")
} else {
    print("The book does not have an official publication date.")
}
```

### **`guard let`**
A `guard` statement acts similarly to an `if-else` condition, but without an `if` block. When you use `guard let`, you are asserting that the optional *must* have a value for the code to continue. 

If the optional is `nil`, the condition fails and the **`else` statement is executed, which must exit the current scope** (usually by calling `return`). If the optional does contain a value, it is automatically unwrapped, and **the unwrapped value remains accessible for the rest of the scope** following the `guard` statement. 

**Example:**
```swift
func testFunction() {
    let someValue: Int? = 5
    
    guard let temp = someValue else {
        // Exits the scope if someValue is nil
        return
    }
    
    // temp is accessible hereafter
    print("It has some value \(temp)") 
}
```

### **Key Differences and When to Use Which**
*   **Scope:** An `if let` traps the unwrapped variable inside its specific code block, whereas `guard let` makes the unwrapped variable available in the scope immediately following the statement.
*   **Readability:** `guard let` is often used as an "early exit" strategy. If you have multiple optionals to unwrap, using `if let` can lead to heavily nested code. Using `guard let` allows you to unwrap multiple optionals and exit early if any are `nil`, which can make your code much cleaner and more readable.

### Q4. Differentiate between `try?`, `try!` and `try` in Swift error handling. Explain with the help of examples

In Swift, **`try`**, **`try?`**, and **`try!`** are used to handle functions that can throw errors, but they manage those potential errors in entirely different ways. 

### **`try` (Standard Error Handling)**
The standard **`try`** keyword is used to call a throwing function. It indicates that the function can throw an error, and it **must be wrapped in a `do-catch` statement** to explicitly handle the error if one occurs. Alternatively, it can be used inside another throwing function to propagate the error to the caller.

**Example:**
```swift
enum SimpleError: Error {
    case somethingWentWrong
}

func doSomething() throws -> String { 
    if true { throw SimpleError.somethingWentWrong } 
    return "Success!" 
} 

do {
    // The try code is wrapped in a do block
    let result = try doSomething() 
    print(result)
} catch {
    // The catch block handles the error gracefully
    print("Error: \(error)") 
}
```

---

### **`try?` (Converting Errors to Optionals)**
The **`try?`** operator **converts an error into an optional value**. It attempts to evaluate the expression, and if it completes successfully, it returns an optional containing the result. **If an error is thrown, the error is ignored and it simply returns `nil`**. 

This is especially useful when the error represents a failure that can be safely ignored or handled in some other way, without needing a full `do-catch` block.

**Example:**
```swift
func loadData(from url: URL) throws -> Data { 
    return Data() 
} 

// If loadData throws an error, 'data' will safely become nil
let data: Data? = try? loadData(from: URL(string: "https://www.kodeco.com")!)
```

---

### **`try!` (Forced Unwrapping)**
The **`try!`** operator forcefully evaluates an expression and **returns a non-optional result** if it completes without an error. However, **if an error is thrown, the program will terminate with a runtime crash**. 

Because it can crash your app, `try!` should only be used when you are absolutely certain that the function will not fail. 

**Example:**
```swift
// If loadData throws an error, the entire application will crash
let data = try! loadData(from: URL(string: "https://www.kodeco.com")!)
```

### **Summary Note**
While `try?` and `try!` can make code shorter, they can make it more difficult to diagnose bugs because the actual error is hidden or causes an immediate crash. It is usually considered best practice to use the standard **`try`** with a `do-catch` block so that errors are handled explicitly and predictably.

### Q5. Explain the concept of delegation in Swift with a real world example.

**Delegation** is a core design pattern in Swift that enables a class or structure to hand off (or "delegate") some of its responsibilities to an instance of another type. This is typically implemented by defining a **protocol** that encapsulates the delegated responsibilities, ensuring that the delegate (the object taking on the responsibility) can perform the required tasks. 

Delegation is widely used to handle events, update data, or decouple objects so they do not need to know the inner workings of one another.

### Real-World Example: A YouTuber and a Video Editor
Imagine a **YouTuber** who shoots videos but does not know how to edit them. Instead of learning to edit, they *delegate* the editing responsibility to a **Video Editor**.

**1. The Protocol (The Job Listing)**
First, you define a protocol that outlines the task that needs to be delegated. Think of this as a job listing that says: "Must be able to edit video."
```swift
protocol EditingDelegate {
    func editVideo(rawFootage: String)
}
```

**2. The Delegator (The YouTuber)**
The YouTuber has an optional `delegate` property. The YouTuber doesn't care *who* the editor is (it could be a freelancer, a studio, or an AI tool), just so long as whoever fills the role conforms to the `EditingDelegate` protocol.
```swift
class YouTuber {
    // The delegate is optional because the YouTuber might not have an editor yet
    var delegate: EditingDelegate?

    func finishShooting(videoName: String) {
        print("YouTuber finished shooting \(videoName).")
        // The YouTuber hands off the editing responsibility to the delegate
        delegate?.editVideo(rawFootage: videoName)
    }
}
```

**3. The Delegate (The Video Editor)**
The Video Editor adopts the `EditingDelegate` protocol and provides the actual implementation for editing the video.
```swift
class VideoEditor: EditingDelegate {
    func editVideo(rawFootage: String) {
        print("Editor is now editing \(rawFootage)!")
    }
}
```

**4. Putting it together**
You create instances of both objects and assign the Video Editor to be the YouTuber's delegate.
```swift
let creator = YouTuber()
let editor = VideoEditor()

// Assign the editor as the YouTuber's delegate
creator.delegate = editor

// When the YouTuber finishes shooting, the editor's delegated method is triggered
creator.finishShooting(videoName: "Travel Vlog")
```
**Output:**
*YouTuber finished shooting Travel Vlog.*
*Editor is now editing Travel Vlog!*

**Why use this?**
By using delegation, the `YouTuber` class and the `VideoEditor` class remain entirely decoupled. The YouTuber never needs to learn how to edit, and the Editor never needs to learn how to be on camera. They communicate only through the shared protocol. If the YouTuber wants to switch editors, they simply assign a new object to the `delegate` property — no other code needs to change.

### Q6. Explain the concept of computed properties in Swift with an example

In Swift, **computed properties do not store a static value in memory**. Instead, they **dynamically calculate and return a value** every time they are accessed, typically based on the current state of other stored properties within the same structure or class. 

Because their value is calculated on the fly and can change, **computed properties must always be declared as variables (`var`), not constants (`let`)**. 

### Example: A Temperature Converter
Consider a `Temperature` structure that stores a temperature in Celsius. Rather than manually updating Fahrenheit and Kelvin values every time the Celsius value changes, you can use computed properties to calculate them automatically:

```swift
struct Temperature {
    // Stored property
    let celsius: Double
    
    // Computed property for Fahrenheit
    var fahrenheit: Double {
        celsius * 1.8 + 32
    }
    
    // Computed property for Kelvin
    var kelvin: Double {
        celsius + 273.15
    }
}
```

In this example, `celsius` is a standard stored property. However, `fahrenheit` and `kelvin` are computed properties containing mathematical expressions. Whenever you ask the program for the `fahrenheit` or `kelvin` value, it executes the code inside the braces `{}` using the current `celsius` value to give you an accurate result.

### Usage
When you create an instance of this structure, you only need to provide the stored `celsius` value:

```swift
let currentTemperature = Temperature(celsius: 0.0)

// Accessing the computed properties
print(currentTemperature.fahrenheit) // Outputs: 32.0
print(currentTemperature.kelvin)     // Outputs: 273.15
```

