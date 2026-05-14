# Set 5

## Question 1
Implement a simple calculator that uses closures for different operations.
- Create an `enum` named `Operation` with cases for `add`, `subtract`, `multiply`, and `divide`.
- Write a function named `calculate` that takes two `Double` values and an `Operation` enum case as input.
- Inside the `calculate` function, define a dictionary where the keys are the `Operation` enum cases and the values are closures that perform the corresponding arithmetic operation on two `Double` inputs and return a `Double`.
- Use a `switch` statement on the `Operation` to retrieve the appropriate closure from the dictionary and execute it with the provided numbers.
- Handle the division by zero case by returning `nil` (make the function return an optional `Double`).
- Demonstrate calling the `calculate` function with different operations and numbers, including a division by zero scenario.

### Code
```swift
enum Operation: Hashable {
    case add, subtract, multiply, divide
}

func calculate(a: Double, b: Double, operation: Operation) -> Double? {
    
    // Dictionary mapping enum cases to closures
    let operationsDict: [Operation: (Double, Double) -> Double?] = [
        .add: { $0 + $1 },
        .subtract: { $0 - $1 },
        .multiply: { $0 * $1 },
        .divide: { $1 == 0 ? nil : $0 / $1 }
    ]
    
    // Switch to retrieve and execute
    switch operation {
    case .add, .subtract, .multiply, .divide:
        if let closure = operationsDict[operation] {
            return closure(a, b)
        }
        return nil
    }
}

if let resultAdd = calculate(a: 10, b: 5, operation: .add) {
    print("Addition: \(resultAdd)")
}

if let resultDiv = calculate(a: 10, b: 0, operation: .divide) {
    print("Division: \(resultDiv)")
} else {
    print("Division by zero prevented.") // This will be printed
}
```

## Question 2
Create a Swift program that manages a guest list for an event:
1. Store guest names in an Array (for ordered access) and a Set (to avoid duplicates).
2. Add, remove, and display guests.
3. Show how both data structures behave when the same name is added twice.

### Code
```swift
var guestArray: [String] = []
var guestSet: Set<String> = []

func addGuest(_ name: String) {
    // 1. Array (Allows duplicates)
    guestArray.append(name)
    
    // 2. Set (Avoids duplicates)
    let (inserted, _) = guestSet.insert(name)
    
    if inserted {
        print("Added '\(name)' to the event.")
    } else {
        print("Set Notification: '\(name)' is already on the guest list (Duplicate ignored).")
    }
}

func removeGuest(_ name: String) {
    if let index = guestArray.firstIndex(of: name) {
        guestArray.remove(at: index)
    }
    guestSet.remove(name)
    print("Removed '\(name)' from the event.")
}

func displayGuests() {
    print("\n--- Guest List ---")
    print("Array (Ordered, Allows Duplicates): \(guestArray)")
    print("Set (Unordered, Unique): \(guestSet)")
    print("------------------\n")
}

// Demonstration
addGuest("Alice")
addGuest("Bob")
displayGuests()

// Adding duplicate
print("Attempting to add 'Alice' again...")
addGuest("Alice") // Array will have two 'Alice's, Set will ignore the duplicate
displayGuests()

// Removing
print("Removing 'Bob'...")
removeGuest("Bob")
displayGuests()
```
