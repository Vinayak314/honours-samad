### Q1. Explain property observers in Swift. What is the difference between `willSet` and `didSet`?

**Property observers** let you run custom code whenever a stored property's value changes.

- **`willSet`** runs **before** the value changes. It gives you access to the incoming value via `newValue`.
- **`didSet`** runs **after** the value changes. It gives you access to the previous value via `oldValue`.

```swift
struct StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

var counter = StepCounter()
counter.totalSteps = 200
// Output:
// About to set totalSteps to 200
// Added 200 steps

counter.totalSteps = 360
// Output:
// About to set totalSteps to 360
// Added 160 steps
```

> **Note:** Property observers are **not called during initialization** — only when the property is set after the instance is fully initialized.

---

### Q2. What are Extensions in Swift? How can you add computed properties and methods to an existing type?

An **extension** adds new functionality to an existing type (class, struct, enum, or protocol) **without modifying its original source code**. Extensions can add:

- Computed properties
- Methods
- New initializers
- Protocol conformance

> **Limitation:** Extensions **cannot** add stored properties or override existing methods.

**Adding a computed property to `Double`:**

```swift
extension Double {
    var km: Double { return self * 1000.0 }
    var cm: Double { return self / 100.0 }
}

print(5.0.km)    // 5000.0
print(150.0.cm)  // 1.5
```

**Adding a method to `Int`:**

```swift
extension Int {
    func squared() -> Int {
        return self * self
    }
}

print(4.squared()) // 16
```

**Adding an initializer via extension (preserves memberwise init):**

```swift
struct Rect {
    var width: Double
    var height: Double
}

extension Rect {
    init(side: Double) {
        self.width = side
        self.height = side
    }
}

let r1 = Rect(width: 10, height: 20) // memberwise init still works
let r2 = Rect(side: 15)               // custom init from extension
```

---

### Q3. Explain class inheritance in Swift. How do you override methods and prevent subclassing?

**Inheritance** allows a class (subclass) to inherit properties, methods, and other characteristics from another class (superclass).

- Use `:` to inherit from a superclass.
- Use `override` to redefine an inherited method or property.
- Use `super` to call the superclass's version.
- Use `final` to prevent a class or method from being overridden.

```swift
class Vehicle {
    var speed: Double = 0.0
    
    func describe() -> String {
        return "Travelling at \(speed) km/h"
    }
}

class Car: Vehicle {
    var gear: Int = 1
    
    // Override the superclass method
    override func describe() -> String {
        return super.describe() + " in gear \(gear)"
    }
}

let car = Car()
car.speed = 80.0
car.gear = 4
print(car.describe()) // Travelling at 80.0 km/h in gear 4
```

**Preventing subclassing or overrides:**

```swift
final class DatabaseManager {
    // This class cannot be subclassed
}

class Animal {
    final func breathe() {
        // This method cannot be overridden
        print("Breathing...")
    }
}
```

> **Key:** Only **classes** support inheritance in Swift. Structs and enums do not.

---

### Q4. Explain the difference between `@autoclosure` and `@escaping` closures in Swift.

**`@autoclosure`** automatically wraps a plain expression into a closure. The caller writes a simple expression without braces.

```swift
func logIfTrue(_ condition: @autoclosure () -> Bool) {
    if condition() {
        print("Condition is true")
    }
}

logIfTrue(5 > 3)   // No braces needed — expression is auto-wrapped
```

**Use case:** Deferred evaluation — the expression is only evaluated when the closure is called. Used internally by `assert()` and `??`.

**`@escaping`** marks a closure that **outlives** the function that receives it (e.g., stored in a property, called after an async operation completes).

```swift
var completionHandlers: [() -> Void] = []

func addHandler(handler: @escaping () -> Void) {
    completionHandlers.append(handler) // Stored for later use
}

addHandler {
    print("Task completed!")
}

completionHandlers[0]() // Called later — Task completed!
```

| Feature | `@autoclosure` | `@escaping` |
|---|---|---|
| Purpose | Auto-wraps expression in closure | Allows closure to outlive function |
| Caller syntax | Writes plain expression | Writes normal closure |
| Common use | `assert()`, `??` | Async callbacks, stored closures |

> **Memory warning:** Escaping closures that capture `self` inside a class can create retain cycles. Use `[weak self]` to prevent memory leaks.

---

### Q5. What is Protocol-Oriented Programming? How do protocol extensions provide default implementations?

**Protocol-Oriented Programming (POP)** is Swift's approach to code reuse where you define shared behavior through protocols and protocol extensions, rather than through class inheritance.

A **protocol extension** can provide **default implementations** of its methods. Any conforming type automatically gets these defaults but can override them.

```swift
protocol Describable {
    var description: String { get }
    func summarize() -> String
}

// Default implementation via protocol extension
extension Describable {
    func summarize() -> String {
        return "Description: \(description)"
    }
}

struct Book: Describable {
    var title: String
    var description: String {
        return "Book: \(title)"
    }
    // summarize() is inherited from the protocol extension
}

let book = Book(title: "Swift Programming")
print(book.summarize()) // Description: Book: Swift Programming
```

**POP vs OOP:**

| Feature | POP (Protocols) | OOP (Classes) |
|---|---|---|
| Reuse mechanism | Protocol extensions | Inheritance |
| Works with | Structs, Enums, Classes | Classes only |
| Multiple conformance | Yes (multiple protocols) | No (single superclass) |
| Value vs Reference | Value types preferred | Reference types only |
