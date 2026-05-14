### Q1. Define a protocol with an associated type and implement it in a struct.

In Swift, an **associated type** acts as a placeholder name within a protocol. It allows you to define properties, methods, and parameters without specifying the exact data type they must use. The actual concrete type is not determined until another type (like a struct or class) adopts the protocol. 

You declare an associated type using the **`associatedtype`** keyword.

Here is an example of defining a protocol with an associated type, and then implementing it in two different ways using structs:

### 1. Defining the Protocol
```swift
protocol MyProtocol {
    // Define the associated type placeholder
    associatedtype E
    
    // Use the placeholder for an array of items
    var items: [E] { get set }
    
    // Use the placeholder for a method parameter
    mutating func add(item: E) 
}
```

### 2. Implementing with a Concrete Type
When a struct adopts this protocol, it can satisfy the requirement by replacing the placeholder `E` with a concrete type, such as an `Int`.
```swift
struct MyIntType: MyProtocol {
    // The struct explicitly uses 'Int' where the protocol used 'E'
    var items: [Int] = []
    
    mutating func add(item: Int) {
        items.append(item)
    }
}
```


### Q2. What is a class-only protocol? Show with the help of an example how to define and use one.

In Swift, a **class-only protocol** is a protocol that can only be adopted by reference types (classes). Value types, such as structures and enumerations, are strictly forbidden from conforming to it. 

You create a class-only protocol by forcing the protocol to inherit from **`AnyObject`**. As the sources note, `AnyObject` is a special type in Swift that "can represent an instance of any class in Swift but not a structure". By making a protocol inherit from `AnyObject`, you pass that class-only restriction down to the protocol itself.

Class-only protocols are typically used when you need to ensure **reference semantics** (sharing the exact same instance in memory rather than a copy). They are also required for the delegation pattern when you need to declare a `delegate` variable as `weak` to prevent memory leaks (retain cycles), because only classes can be marked as `weak`. 

### Example: Defining and Using a Class-Only Protocol

Here is an example showing how to define a class-only protocol and how it restricts usage:

```swift
// 1. Define a class-only protocol by inheriting from AnyObject
protocol FileDownloadDelegate: AnyObject {
    func didFinishDownloading(file: String)
}

// 2. A Class CAN conform to a class-only protocol
class DownloadManager: FileDownloadDelegate {
    func didFinishDownloading(file: String) {
        print("Successfully downloaded \(file)")
    }
}

// 3. Using the protocol in a system (Delegation)
class Downloader {
    // Because the protocol is class-only, we can safely mark this as 'weak'
    weak var delegate: FileDownloadDelegate?
    
    func startDownload() {
        // Notify the delegate when finished
        delegate?.didFinishDownloading(file: "Swift_Guide.pdf")
    }
}
```
### Q3. How is `as?` different from `as!` in type casting? Illustrate with a code snippet.

In Swift, both **`as?`** and **`as!`** are used for downcasting, which is the process of converting a superclass instance to a subclass type. The primary difference lies in how they handle failures and the type of value they return:

*   **`as?` (Conditional Downcast):** This operator attempts the downcast and **returns an optional value** (`Type?`). If the cast is successful, it contains the downcasted value; if the cast fails, it safely returns `nil`. 
*   **`as!` (Forced Downcast):** This operator forces the downcast and **returns a non-optional value** (`Type`). Because it is forced, if the downcast fails, it will trigger a runtime error and crash your app. You should only use `as!` when you are absolutely certain of the instance's underlying type.

### Code Snippet Example
Here is how you might use both when working with a generic `Animal` superclass and a `Dog` subclass:

```swift
class Animal {}

class Dog: Animal {
    func bark() {
        print("Woof!")
    }
}

// Upcasting a Dog instance to an Animal
let animal: Animal = Dog() 

// 1. Using as? (Conditional Downcast)
// Safely checks the type and unwraps the optional if successful
if let dog = animal as? Dog {
    dog.bark() // Outputs: Woof!
} else {
    print("Not a Dog")
}

// 2. Using as! (Forced Downcast)
// Forces the cast into a non-optional. Crashes if 'animal' is not actually a Dog!
let forcedDog = animal as! Dog
forcedDog.bark() // Outputs: Woof!
```

### Q4. Write a Swift struct that conforms to the `Hashable` protocol and explain its significance.

The **`Hashable`** protocol is highly significant in Swift because a data type **must be hashable in order to be stored inside a `Set`**. As previously discussed, a `Set` is a collection that stores distinct values with no defined ordering, ensuring that an item only ever appears once. 

While Swift's basic types—such as `String`, `Int`, `Double`, and `Bool`—are hashable by default, custom data types like structs or classes must explicitly adopt the protocol if you want to store them in a set or use them as dictionary keys.


### Example: A `Hashable` Struct
In Swift, if a struct's stored properties are all natively hashable (like `String` and `Int`), you simply need to declare conformance to the protocol, and Swift will synthesize the hashing logic automatically:

```swift
// 1. Define a struct that conforms to the Hashable protocol
struct Student: Hashable {
    let name: String
    let idNumber: Int
}

// 2. Because Student is Hashable, it can now be stored in a Set
var registeredStudents = Set<Student>()

let student1 = Student(name: "Amy", idNumber: 101)
let student2 = Student(name: "Brad", idNumber: 102)
let student3 = Student(name: "Amy", idNumber: 101) // Identical to student1

// 3. Inserting the students into the set
registeredStudents.insert(student1)
registeredStudents.insert(student2)

// Because the set relies on the Hashable protocol, it recognizes 
// student3 is a duplicate of student1 and will ignore it.
registeredStudents.insert(student3) 

print(registeredStudents.count) 
// Outputs: 2
```

### Q5. Explain the role of generics in enhancing type safety with an example.

In Swift, **type safety** means that the compiler performs checks on your constants and variables at compile time, flagging any mismatched types as errors to ensure your code works with clear, predictable data types. 

**Generics enhance type safety** by allowing you to write flexible, reusable code without sacrificing these strict compiler checks. Instead of writing separate functions for every single data type (like one for `Int`, one for `Double`, etc.), or resorting to unsafe broad types like `Any`, you define a generic function using a **type parameter** or placeholder, such as `<T>`. 

When you call a generic function, Swift replaces that placeholder with the actual data type passed in, ensuring that the types remain consistent throughout the function's parameters and return values. Furthermore, you can enhance this safety using **type constraints**, which restrict the generic placeholder so it must conform to specific protocols, guaranteeing the generic type has the required capabilities before the code even compiles.

### Example: Finding the Maximum Value
Without generics, you would have to write completely separate functions to find the maximum value in an array of integers versus an array of doubles. With generics, you can write a single, type-safe function. 

In the following example, the generic placeholder `<T>` is constrained to the `Comparable` protocol (`<T: Comparable>`). This guarantees to the compiler that the items in the array can safely be compared using the `>` operator.

```swift
// Generic function to find the maximum element in an array
func findMax<T: Comparable>(_ array: [T]) -> T? {
    guard !array.isEmpty else {
        return nil // Handle empty array case
    }
    
    var maxElement = array // Initialize with the first element
    
    for element in array {
        // Because T is Comparable, the compiler safely allows this check
        if element > maxElement {
            maxElement = element
        }
    }
    
    // The compiler guarantees the return type is the exact same type T
    return maxElement
}

// Safely used with an Int array
let intArray =
if let maxInt = findMax(intArray) {
    print("Max integer: \(maxInt)") // Output: Max integer: 9
}

// Safely used with a Double array
let doubleArray = [1.5, 2.7, 0.8, 3.2]
if let maxDouble = findMax(doubleArray) {
    print("Max double: \(maxDouble)") // Output: Max double: 3.2
}
```

In this example, type safety is maintained perfectly: the compiler knows exactly what type `T` is in each context, guarantees that the return value matches the type of the array's elements, and ensures the code will never compile if you pass an array of items that cannot be compared.


