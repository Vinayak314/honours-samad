### Q1. Define a closure? Write a closure that calculates the factorial of a number.

**Closures are anonymous functions**—often referred to as lambdas or blocks—that act as blocks of code you can pass as arguments to other functions. In Swift, closures are a special type of function that can be **defined without using the `func` keyword or a function name**. Just like standard functions, closures can accept parameters, return values, and be assigned to a variable or a constant. 

The basic syntax for a closure uses the `in` keyword to separate the parameters and return type from the main body of the closure:
`{ (parameters) -> returnType in // statements }`.


### Factorial Closure Example
Here is how you can write a closure that accepts a number and calculates its factorial:

```swift
// Define a closure that accepts an Int and returns an Int
let calculateFactorial = { (num: Int) -> Int in
    // The factorial of 0 is always 1
    if num == 0 {
        return 1
    }
    
    var result = 1
    // Loop through 1 up to the given number and multiply
    for i in 1...num {
        result *= i
    }
    
    return result
}

// Call the closure by passing a number
let result = calculateFactorial(5)
print("The factorial is \(result)") 
// Output: The factorial is 120
```

### Q2. Explain an enum in Swift and how is it declared? Give one example.

In Swift, an enumeration (or **`enum`**) allows you to define a common, type-safe data structure for a group of related values. By using an enum, you ensure that a variable can only be assigned one of the specific, predefined cases, which prevents errors that might occur if you used plain strings or integers to represent those states.

### **How to Declare an Enum**
You declare an enum using the `enum` keyword followed by the capitalized name of the enumeration. Inside the braces, you define the available options using the `case` keyword. You can list each case on its own line, or you can save space by grouping multiple cases on a single line separated by commas.

### **Example**
Here is an example of an enum representing points on a compass, defined on separate lines:
```swift
enum CompassPoint {
    case north
    case east
    case south
    case west
}
```

Here is another example representing movie genres, defined using the single-line shorthand:
```swift
enum Genre {
    case animated, action, romance, documentary, biography, thriller
}
```

Once declared, you can assign an enum value to a variable or constant. If the variable's type is already known or explicitly annotated, you can drop the enum's name and use a shorthand dot syntax (like `.west` or `.animated`) to assign or check its value:

```swift
// Explicitly stating the enum name
var compassHeading = CompassPoint.west 

// Using dot syntax once the type is known
compassHeading = .north 

// Using the enum inside a struct
struct Movie {
    var name: String
    var releaseYear: Int?
    var genre: Genre
}

let movie = Movie(name: "Finding Dory", releaseYear: 2016, genre: .animated)
```

### Q3. Difference between `var` and `let` in Swift with examples. Why would you use one over the other?

In Swift, the fundamental difference between **`let`** and **`var`** comes down to whether or not a value can be modified after it is initially set.

### **`let` (Constants)**
You use the **`let`** keyword to define a **constant**. Once a constant is allocated in memory and assigned a value, **it cannot be changed or reassigned**. 

**When to use it:** You should use `let` whenever you are working with a value that will not change throughout the lifecycle of your code, such as a mathematical constant (like Pi) or a fixed configuration value. Swift enforces this strictly; if you attempt to assign a new value to a `let` constant, the compiler will throw an error.

**Example:**
```swift
let name = "John"
let pi = 3.14159

// Attempting to change the name will result in an error:
// name = "James"  (Cannot assign to value: 'name' is a 'let' constant!)
```

### **`var` (Variables)**
You use the **`var`** keyword to define a **variable**. Unlike constants, a variable's value **can be modified, updated, or reassigned** as many times as needed, provided the new value is of the same data type. 

**When to use it:** You should use `var` when you have a value that needs to change dynamically as your program runs, such as a user's age, a player's score, or an updating calculation.

**Example:**
```swift
var age = 29
age = 30 // The value is successfully updated to 30

var shoeSize = 8
shoeSize = 9 // The value is successfully updated to 9
```

### Q4. Difference between an `Array` and a `Set` in Swift? Explain with example.

In Swift, the primary differences between an **`Array`** and a **`Set`** come down to **ordering**, **uniqueness**, and **initialization**. 

### **`Array`**
An array is a collection where the **order of elements is maintained**, and you can access, insert, or remove elements using a specific integer index. Arrays **allow duplicate values**. When you assign a bracketed list of values to a variable, Swift automatically infers it as an Array.

**Example:**
```swift
// Swift automatically infers this as an [String] Array
var names = ["Amy", "Brad", "Chelsea"] 

names.append("Amy") // Duplicates are perfectly fine
names.insert("Bob", at: 0) // Order matters, so you can insert at specific indexes

print(names) // Elements are accessed by index. Outputs: "Amy"
```

### **`Set`**
A set stores **distinct values with no defined ordering**. You should use a set instead of an array when the order of the items does not matter, or when you must ensure that an item **only appears once** in the collection. 

Because they are fundamentally different from arrays under the hood, sets have a few unique rules:
*   **No Indexing:** Because sets are unordered, you cannot access their elements using an integer index; instead, you iterate over them or check if they contain a specific item using `.contains()`.
*   **Type Declaration:** A set type cannot be automatically inferred from an array literal. If you do not explicitly declare the type as a `Set`, Swift will assume it is an Array. 
*   **Hashable:** All types stored in a set must be "hashable" so the set can quickly look them up. Swift's basic types like `String`, `Int`, `Double`, and `Bool` are hashable by default.
*   **Set Mathematics:** Sets give you access to fundamental mathematical operations, allowing you to easily combine or compare two different sets using `.union()`, `.intersection()`, `.subtracting()`, and `.symmetricDifference()`.

**Example:**
```swift
// You must explicitly declare the Set type
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

favoriteGenres.insert("Jazz")
favoriteGenres.insert("Rock") // "Rock" is already in the set, so this duplicate is ignored

// You cannot do favoriteGenres. Instead, you iterate or check contents:
if favoriteGenres.contains("Jazz") {
    print("Jazz is included.")
}

// The output order will be random because sets are unordered
for genre in favoriteGenres {
    print(genre) 
}
```