# Module 3 — Optionals, Type Casting, Guard, Scope & Enumerations (Practice Questions)

> Covers optionals and unwrapping, type casting (is/as?/as!), guard statements, variable scope, and enumerations with raw/associated values.

---

## 3-01: Optionals

---

### Q1. What are optionals in Swift? Why do they exist? Explain how to declare and use them with examples.

#### Answer

An **optional** is a type that can hold either a **value** or **`nil`** (no value). They exist to enforce safe handling of missing data at compile time — you cannot accidentally use a `nil` value without explicitly addressing it.

**Declaring optionals:**

```swift
var name: String? = "Aman"     // Optional with a value
var age: Int? = nil             // Optional with no value

// Without the ?, a variable CANNOT be nil:
// var score: Int = nil  // ❌ Compile error
```

**Important:** The type of `name` above is not `String` — it is `Optional<String>`, or `String?` for short. These are two completely different types. You cannot pass a `String?` where a `String` is expected without unwrapping it first.

**Mental model:** Think of an optional as a **box** that might contain a value or might be empty. Unwrapping is the act of opening the box to get the value inside.

---

### Q2. Explain all the ways to safely unwrap an optional in Swift. Provide an example of each.

#### Answer

### 1. Optional Binding (`if let`)

```swift
let email: String? = "aman@mail.com"

if let unwrapped = email {
    print("Email: \(unwrapped)")
} else {
    print("No email")
}
// Output: Email: aman@mail.com
```

### 2. Guard Statement (`guard let`)

```swift
func greet(name: String?) {
    guard let unwrapped = name else {
        print("No name"); return
    }
    print("Hello, \(unwrapped)")
}
greet(name: "Riya")   // Hello, Riya
greet(name: nil)       // No name
```

### 3. Nil-Coalescing Operator (`??`)

Provides a **default value** when the optional is `nil`.

```swift
let username: String? = nil
let display = username ?? "Guest"
print(display)   // Guest
```

### 4. Optional Chaining

Accesses properties/methods on an optional. Returns `nil` if the optional is `nil` — no crash.

```swift
let name: String? = "Swift"
let count = name?.count    // Optional(5)

let empty: String? = nil
let count2 = empty?.count  // nil
```

### 5. Forced Unwrapping (`!`) — **Unsafe**

Directly extracts the value. **Crashes** if the optional is `nil`.

```swift
let name: String? = "Aman"
print(name!)   // Aman

// let x: String? = nil
// print(x!)   // ❌ CRASH — Fatal error: unexpectedly found nil
```

> **Rule:** Avoid `!` unless you are 100% certain the value exists. In professional Swift code, forced unwrapping is considered a code smell — it means "crash here if I'm wrong," and you should ask yourself why you can't use a safer alternative.

---

### Q3. What is implicitly unwrapped optional (`!`) vs a regular optional (`?`)? When should each be used?

#### Answer

| Feature | Regular Optional (`?`) | Implicitly Unwrapped Optional (`!`) |
|---|---|---|
| Declaration | `var name: String?` | `var name: String!` |
| Access | Must unwrap before use | Auto-unwrapped when accessed |
| Safety | Safe — compiler forces nil check | Unsafe — crashes if nil when accessed |
| Use case | When value may or may not exist | When value is nil initially but guaranteed to have a value before use |

**Example:**

```swift
// Regular optional
var a: String? = "Hello"
// print(a.count)  // ❌ Error — must unwrap first
print(a!.count)    // 5

// Implicitly unwrapped optional
var b: String! = "Hello"
print(b.count)     // 5 — no need to unwrap explicitly
```

**When to use `!` declaration:**

- Primarily used for `@IBOutlet` connections in UIKit, which are `nil` before the view loads but guaranteed to have a value after `viewDidLoad()`.

```swift
@IBOutlet weak var label: UILabel!   // nil until storyboard loads
```

**Caution:** Even though IUOs are the convention for outlets, they can still crash if you access them before the view loads (e.g., in `init()` or before `viewDidLoad()`). Be mindful of the ViewController lifecycle.

---

## 3-02: Type Casting and Inspection

---

### Q4. Explain type casting in Swift. What are the `is`, `as?`, and `as!` operators? Provide examples.

#### Answer

**Type casting** checks the type of an instance or treats it as a different type within a class hierarchy. This is essential when working with **polymorphism** — when you have a collection of base class types and need to access subclass-specific properties or methods.

| Operator | Name | Behavior |
|---|---|---|
| `is` | Type check | Returns `true` if instance is of that type |
| `as?` | Conditional downcast | Returns optional; `nil` if cast fails |
| `as!` | Forced downcast | Crashes if cast fails |

**Class hierarchy:**

```swift
class Vehicle {
    var name: String
    init(name: String) { self.name = name }
}

class Car: Vehicle {
    var doors: Int
    init(name: String, doors: Int) {
        self.doors = doors
        super.init(name: name)
    }
}

class Bicycle: Vehicle {}

let vehicles: [Vehicle] = [
    Car(name: "Sedan", doors: 4),
    Bicycle(name: "BMX")
]
```

**`is` — Type Check:**

```swift
for v in vehicles {
    if v is Car {
        print("\(v.name) is a Car")
    }
}
// Sedan is a Car
```

**`as?` — Safe Downcast:**

```swift
if let car = vehicles[0] as? Car {
    print("\(car.name) has \(car.doors) doors")   // Sedan has 4 doors
}
```

**`as!` — Forced Downcast:**

```swift
let car = vehicles[0] as! Car
print(car.doors)   // 4
// let bike = vehicles[0] as! Bicycle   // ❌ Runtime crash
```

---

### Q5. Explain upcasting and downcasting in Swift with examples.

#### Answer

### Upcasting (`as`)

Treats a subclass instance as its **superclass** type. Always succeeds.

```swift
class Animal { var name = "Animal" }
class Dog: Animal { var breed = "Lab" }

let dog = Dog()
let animal: Animal = dog as Animal   // upcast
print(animal.name)    // Animal
// animal.breed        // ❌ Error — Animal type has no 'breed'
```

### Downcasting (`as?` / `as!`)

Treats a superclass reference as a **subclass** type.

```swift
let animals: [Animal] = [Dog(), Animal()]

for a in animals {
    if let dog = a as? Dog {
        print("Dog breed: \(dog.breed)")
    } else {
        print("Not a dog")
    }
}
// Dog breed: Lab
// Not a dog
```

| Direction | Operator | Safety |
|---|---|---|
| Upcast | `as` | Always safe |
| Downcast | `as?` | Safe — returns optional |
| Downcast | `as!` | Unsafe — crashes on failure |

**Best practice:** Always prefer `as?` (conditional downcast) over `as!` (forced downcast). If you need the cast to succeed to proceed, combine `as?` with `guard let` for safe early exit.

---

### Q6. Explain type casting with `switch` in Swift. Provide an example with an `[Any]` array.

#### Answer

The `switch` statement can match and cast types using `as`, making it ideal for handling heterogeneous collections.

```swift
let items: [Any] = [42, "Hello", 3.14, true, "Swift"]

for item in items {
    switch item {
    case let intVal as Int:
        print("Integer: \(intVal)")
    case let strVal as String:
        print("String: \(strVal)")
    case let doubleVal as Double:
        print("Double: \(doubleVal)")
    case let boolVal as Bool:
        print("Boolean: \(boolVal)")
    default:
        print("Unknown type")
    }
}
// Integer: 42
// String: Hello
// Double: 3.14
// Boolean: true
// String: Swift
```

**With a class hierarchy:**

```swift
class Shape {}
class Circle: Shape { var radius = 5.0 }
class Square: Shape { var side = 4.0 }

let shapes: [Shape] = [Circle(), Square(), Circle()]

for shape in shapes {
    switch shape {
    case let c as Circle:
        print("Circle, radius \(c.radius)")
    case let s as Square:
        print("Square, side \(s.side)")
    default:
        print("Unknown shape")
    }
}
```

---

## 3-03: Guard

---

### Q7. What is the `guard` statement in Swift? How is it different from `if let`? Provide examples.

#### Answer

**`guard`** is used for **early exit**. It checks a condition and if the condition is `false`, the `else` block must exit the current scope (`return`, `break`, `throw`, etc.).

### `guard let` vs `if let`

| Feature | `if let` | `guard let` |
|---|---|---|
| Unwrapped value scope | Inside the `if` block only | Rest of the enclosing function |
| `else` block | Optional | **Mandatory** (must exit) |
| Best for | Short optional code paths | Validating preconditions early |
| Nesting | Can cause deep nesting | Keeps happy path flat |

### Example — `if let` (nested)

```swift
func processOrder(item: String?, quantity: Int?) {
    if let item = item {
        if let quantity = quantity {
            if quantity > 0 {
                print("Order: \(quantity)x \(item)")
            } else {
                print("Invalid quantity")
            }
        } else {
            print("Missing quantity")
        }
    } else {
        print("Missing item")
    }
}
```

### Same logic with `guard` (flat and readable)

```swift
func processOrder(item: String?, quantity: Int?) {
    guard let item = item else {
        print("Missing item"); return
    }
    guard let quantity = quantity else {
        print("Missing quantity"); return
    }
    guard quantity > 0 else {
        print("Invalid quantity"); return
    }
    // Happy path — no nesting
    print("Order: \(quantity)x \(item)")
}

processOrder(item: "Book", quantity: 3)     // Order: 3x Book
processOrder(item: nil, quantity: 3)         // Missing item
processOrder(item: "Pen", quantity: nil)     // Missing quantity
processOrder(item: "Pen", quantity: -1)      // Invalid quantity
```

**When to use `guard`:** Use it at the **top of a function** to validate all preconditions. This keeps the main logic un-indented and the function's "contract" clearly visible. If someone reads only the `guard` statements, they immediately know what inputs the function requires.

---

### Q8. Can `guard` be used without optionals? Provide an example of `guard` with a Boolean condition.

#### Answer

Yes. `guard` can check **any Boolean condition**, not just optionals.

```swift
func validateAge(_ age: Int) {
    guard age >= 0 else {
        print("Age cannot be negative"); return
    }
    guard age >= 18 else {
        print("Must be 18 or older"); return
    }
    print("Access granted, age: \(age)")
}

validateAge(25)    // Access granted, age: 25
validateAge(15)    // Must be 18 or older
validateAge(-3)    // Age cannot be negative
```

**`guard` with multiple conditions:**

```swift
func login(username: String, password: String) {
    guard !username.isEmpty, !password.isEmpty else {
        print("Fields cannot be empty"); return
    }
    guard password.count >= 8 else {
        print("Password must be at least 8 characters"); return
    }
    print("Logging in as \(username)")
}

login(username: "admin", password: "secure123")   // Logging in as admin
login(username: "", password: "123")               // Fields cannot be empty
login(username: "admin", password: "short")        // Password must be at least 8 characters
```

---

## 3-04: Scope

---

### Q9. What is scope in Swift? Explain the difference between global scope, local scope, and how scope affects variable lifetime.

#### Answer

**Scope** determines where a variable or constant is accessible and how long it exists in memory.

### Types of Scope

| Scope | Where defined | Accessible from |
|---|---|---|
| **Global** | Outside any function, class, or struct | Anywhere in the file/module |
| **Local** | Inside a function, loop, or block `{ }` | Only within that block |

### Example

```swift
// Global scope
var globalVar = "I am global"

func example() {
    // Local scope
    var localVar = "I am local"
    print(globalVar)   // ✅ Can access global from local
    print(localVar)    // ✅ Accessible here

    if true {
        // Nested local scope
        var innerVar = "I am inner"
        print(localVar)   // ✅ Can access outer local
        print(innerVar)   // ✅ Accessible here
    }
    // print(innerVar)    // ❌ Error — innerVar is out of scope
}

example()
// print(localVar)        // ❌ Error — localVar is out of scope
```

### Key Rules

1. **Inner scopes can access outer scope** variables.
2. **Outer scopes cannot access inner scope** variables.
3. A variable is **destroyed** when its scope ends.
4. If two variables have the **same name** in nested scopes, the innermost one takes priority (**shadowing**).

**Why scope matters:** Understanding scope prevents bugs where you accidentally reference the wrong variable, and helps you reason about when memory is freed (a variable's memory is released when its scope ends).

**Shadowing example:**

```swift
var x = 10              // outer scope

func demo() {
    var x = 20          // shadows the outer x
    print(x)            // 20
}

demo()
print(x)               // 10 — outer x unchanged
```

---

### Q10. How does scope relate to `if let` and `guard let`? Explain with examples.

#### Answer

This is a key practical difference:

### `if let` — value scoped to the `if` block

```swift
func example(name: String?) {
    if let unwrapped = name {
        print(unwrapped)       // ✅ accessible here
    }
    // print(unwrapped)        // ❌ out of scope
}
```

### `guard let` — value scoped to the rest of the function

```swift
func example(name: String?) {
    guard let unwrapped = name else { return }
    // unwrapped is available for the rest of the function
    print(unwrapped)           // ✅ accessible here
    print(unwrapped.count)     // ✅ still accessible
}
```

This is exactly **why `guard let` is preferred** when you need the unwrapped value throughout the function — it extends the scope.

---

## 3-05: Enumerations

---

### Q11. What are enumerations in Swift? Explain with examples of basic enums, raw values, and associated values.

#### Answer

An **enumeration** (enum) defines a group of related values as a single type.

### Basic Enum

```swift
enum Direction {
    case north, south, east, west
}

var heading = Direction.north
heading = .east    // shorthand (type already known)
```

### Enum with Raw Values

Each case has a **fixed, compile-time** value of the same type.

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars
    // venus = 2, earth = 3, mars = 4 (auto-incremented)
}

print(Planet.earth.rawValue)        // 3
let p = Planet(rawValue: 2)         // Optional(Planet.venus)
```

```swift
enum Suit: String {
    case hearts, diamonds, clubs, spades
}
print(Suit.hearts.rawValue)         // "hearts"
```

### Enum with Associated Values

Each case carries **different data**, determined at **runtime**.

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qr(String)
}

let product = Barcode.upc(8, 85909, 51226, 3)

switch product {
case .upc(let a, let b, let c, let d):
    print("UPC: \(a)-\(b)-\(c)-\(d)")
case .qr(let code):
    print("QR: \(code)")
}
// UPC: 8-85909-51226-3
```

| Feature | Raw Values | Associated Values |
|---|---|---|
| Type | Same for all cases | Different per case |
| When set | Compile time (fixed) | Runtime (per instance) |
| Access | `.rawValue` | Pattern matching |

**Common patterns in iOS:**
- **Raw values** are often used for serialization — converting enums to/from JSON strings or database integers.
- **Associated values** are used in `Result<Success, Failure>`, `Optional` (which is actually an enum!), and state machines.

---

### Q12. How can enums have computed properties and methods in Swift? Provide an example.

#### Answer

Swift enums can contain **computed properties** and **methods** (but **not** stored properties).

```swift
enum TrafficLight {
    case red, yellow, green

    // Computed property
    var waitTime: Int {
        switch self {
        case .red:    return 60
        case .yellow: return 5
        case .green:  return 45
        }
    }

    // Method
    func instruction() -> String {
        switch self {
        case .red:    return "Stop"
        case .yellow: return "Slow down"
        case .green:  return "Go"
        }
    }
}

let light = TrafficLight.red
print(light.waitTime)        // 60
print(light.instruction())  // Stop
```

---

### Q13. What is the advantage of using an enum over a String or Int constant to represent a fixed set of values? Provide an example.

#### Answer

Using an enum provides **type safety** and **exhaustive checking**. A `String` or `Int` allows any arbitrary value, including typos and invalid states.

**Using String (fragile):**

```swift
func handleStatus(_ status: String) {
    if status == "pending" { print("Waiting...") }
    // What if someone passes "pnding"? No compile error!
}
handleStatus("pnding")   // Silent bug — does nothing
```

**Using Enum (safe):**

```swift
enum OrderStatus {
    case pending, shipped, delivered, cancelled
}

func handleStatus(_ status: OrderStatus) {
    switch status {
    case .pending:   print("Waiting...")
    case .shipped:   print("On the way")
    case .delivered: print("Arrived")
    case .cancelled: print("Cancelled")
    }
    // Compiler ensures ALL cases are handled
}

handleStatus(.pending)    // Waiting...
// handleStatus(.pnding)  // ❌ Compile error — no such case
```

| Problem | String/Int | Enum |
|---|---|---|
| Typos | Compile silently | Caught at compile time |
| Missed cases | No warning | Compiler forces exhaustive switch |
| Invalid values | Any string/number allowed | Only defined cases allowed |

**Bottom line:** Enums turn **runtime errors into compile-time errors**. A typo in a string silently does nothing; a typo in an enum case won't even compile. This is one of Swift's core strengths — catching mistakes as early as possible.
