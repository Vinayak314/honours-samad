# Set 1

## Question 1
Write a swift program to perform following:
a. Write a Swift closure named `add` that takes two `Int` values and returns their sum.
b. Write a function named `performOperation` that takes two `Int` values and a closure that takes two `Int` and returns an `Int`.
c. Call `performOperation` with two numbers and the `add` closure, and print the result.
Write another closure named `multiply` that multiplies two `Int` values and call `performOperation` with it.

### Code
```swift
// a. Closure named 'add'
let add: (Int, Int) -> Int = { (a, b) in
    return a + b
}

// b. Function named 'performOperation'
func performOperation(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

// c. Call with 'add' closure
let sumResult = performOperation(a: 5, b: 3, operation: add)
print("Sum: \(sumResult)")

// Multiply closure and call
let multiply: (Int, Int) -> Int = { $0 * $1 }
let multiplyResult = performOperation(a: 5, b: 3, operation: multiply)
print("Product: \(multiplyResult)")
```

## Question 2
Write a swift program for Basic Device Control with following conditions:
- Create a protocol named `Switchable` with a `isOn` property (`Bool`) and a `toggle()` function.
- Create a struct `Light` that conforms to `Switchable`.
- Implement the `toggle()` function in `Light` to flip the `isOn` property.
- Create an instance of `Light` and demonstrate calling the `toggle()` function twice, printing the `isOn` status after each call.

### Code
```swift
protocol Switchable {
    var isOn: Bool { get set }
    mutating func toggle()
}

struct Light: Switchable {
    var isOn: Bool = false
    
    mutating func toggle() {
        isOn.toggle()
    }
}

var livingRoomLight = Light()
print("Initial state: \(livingRoomLight.isOn)")

livingRoomLight.toggle()
print("After first toggle: \(livingRoomLight.isOn)")

livingRoomLight.toggle()
print("After second toggle: \(livingRoomLight.isOn)")
```
