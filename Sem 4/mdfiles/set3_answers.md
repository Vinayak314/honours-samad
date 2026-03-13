# Set 3 — Fundamentals of Swift Programming

> This set covers optionals and unwrapping, property observers, subscripts, and enums vs structs/classes.

---

## Q1. What are optionals in Swift? Explain with an example how to safely unwrap an optional.

### Answer

An **optional** in Swift is a type that represents a value that may or may not be present. An optional can hold either a valid value or `nil` (the absence of a value).

**Syntax:** A type is made optional by appending `?` to it.

```swift
var name: String? = "Aman"   // contains a value
var age: Int? = nil           // contains no value
```

**Why optionals exist:** Unlike languages like Java or JavaScript where `null` can appear anywhere and cause runtime crashes ("null pointer exceptions"), Swift makes the possibility of `nil` **explicit in the type system**. If a variable is `String`, it will **always** have a string. If it's `String?`, it **might** be `nil`, and the compiler forces you to handle that possibility. This catches bugs at compile time instead of runtime.

### Safely Unwrapping Optionals

There are several ways to safely unwrap an optional:

### 1. Optional Binding (`if let`)

```swift
let email: String? = "aman@example.com"

if let unwrappedEmail = email {
    print("Email is: \(unwrappedEmail)")
} else {
    print("No email provided")
}
// Output: Email is: aman@example.com
```

### 2. Guard Statement (`guard let`)

```swift
func printEmail(email: String?) {
    guard let unwrappedEmail = email else {
        print("No email provided")
        return
    }
    print("Email is: \(unwrappedEmail)")
}

printEmail(email: "riya@example.com")  // Email is: riya@example.com
printEmail(email: nil)                  // No email provided
```

### 3. Nil-Coalescing Operator (`??`)

Provides a default value if the optional is `nil`.

```swift
let name: String? = nil
let displayName = name ?? "Guest"
print(displayName)  // Guest
```

### 4. Optional Chaining

Accesses properties/methods on an optional; returns `nil` if the optional is `nil`.

```swift
let name: String? = "Swift"
let count = name?.count   // Optional(5)
```

### Choosing the Right Approach

| Method | Best when... |
|---|---|
| `if let` | You need the value for a short block of code |
| `guard let` | You need the value for the rest of the function |
| `??` | You have a sensible default value |
| Optional chaining | You want to access a property/method and are okay getting `nil` back |
| `!` (forced) | You are 100% certain it's not `nil` (rare — avoid in production code) |

---

## Q2. What are property observers in Swift? Explain the difference between willSet and didSet with an example.

### Answer

**Property observers** are blocks of code that are called automatically whenever a stored property's value is about to change or has just changed. They let you respond to changes in a property's value.

Swift provides two property observers:

- **`willSet`** — called **just before** the value is stored. It provides the new value as a constant called `newValue`.
- **`didSet`** — called **immediately after** the new value is stored. It provides the old value as a constant called `oldValue`.

### Key Points

- Property observers can be added to any **stored property** (except lazy properties).
- They are **not called during initialization** — only during subsequent assignments. This prevents observers from firing before the object is fully set up.
- `willSet` has access to `newValue` (the value about to be set).
- `didSet` has access to `oldValue` (the value that was just replaced).
- You can use **both** `willSet` and `didSet` on the same property, or just one of them.

### Example

```swift
struct TemperatureMonitor {
    var temperature: Double = 25.0 {
        willSet {
            print("Temperature will change from \(temperature) to \(newValue)")
        }
        didSet {
            print("Temperature changed from \(oldValue) to \(temperature)")
            if temperature > 40 {
                print("⚠️ Warning: High temperature!")
            }
        }
    }
}

var monitor = TemperatureMonitor()
monitor.temperature = 35.0
// Output:
// Temperature will change from 25.0 to 35.0
// Temperature changed from 25.0 to 35.0

monitor.temperature = 45.0
// Output:
// Temperature will change from 35.0 to 45.0
// Temperature changed from 35.0 to 45.0
// ⚠️ Warning: High temperature!
```

### Comparison

| Feature | `willSet` | `didSet` |
|---|---|---|
| When called | Before the value changes | After the value changes |
| Special constant | `newValue` (incoming value) | `oldValue` (previous value) |
| Typical use | Logging, validation preview | Updating UI, triggering side effects |

### Real-World Use Cases in iOS

- **Updating UI labels** when a data property changes (e.g., score changes → update scoreLabel).
- **Input validation** — clamping values to a valid range inside `didSet`.
- **Triggering network calls** when a filter or search term changes.
- **Logging/analytics** — tracking when and how values change.

```swift
// Example: clamping a value in didSet
var volume: Int = 50 {
    didSet {
        if volume > 100 { volume = 100 }
        if volume < 0 { volume = 0 }
    }
}
```

---

## Q3. What are subscripts in Swift? How do they enhance data access in custom types? Provide an example.

### Answer

A **subscript** is a shortcut for accessing elements of a collection, list, or sequence. Subscripts allow you to use the `[]` (square bracket) syntax to get and set values on your own custom types, similar to how arrays and dictionaries work.

**How they enhance data access:**

- Provide a concise, natural syntax for accessing data (e.g., `matrix[0, 1]`).
- Eliminate the need for separate getter/setter methods.
- Can accept any number and type of input parameters.
- Can be read-only or read-write.

### Syntax

```swift
subscript(index: Int) -> ElementType {
    get {
        // return the value at index
    }
    set(newValue) {
        // set the value at index
    }
}
```

### Example

```swift
struct MultiplicationTable {
    var base: Int

    subscript(index: Int) -> Int {
        return base * index
    }
}

let table = MultiplicationTable(base: 5)
print(table[3])   // 15  (5 × 3)
print(table[7])   // 35  (5 × 7)
```

**Read-write subscript example:**

```swift
struct Matrix {
    var rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }

    subscript(row: Int, col: Int) -> Double {
        get {
            return grid[row * columns + col]
        }
        set {
            grid[row * columns + col] = newValue
        }
    }
}

var mat = Matrix(rows: 2, columns: 2)
mat[0, 0] = 1.0
mat[0, 1] = 2.0
mat[1, 0] = 3.0
mat[1, 1] = 4.0
print(mat[1, 0])  // 3.0
```

### When to Use Subscripts

- When your type **conceptually represents a collection** or has elements that can be accessed by index or key.
- When `[]` syntax makes the code **more readable** than explicit getter/setter methods.
- Array, Dictionary, and String in Swift all use subscripts internally — you're creating the same intuitive interface for your own types.

---

## Q4. What is the advantage of using enum over struct or class in certain scenarios? Provide an example.

### Answer

**Enums** are the best choice when a value can only be one of a **fixed, finite set of cases**. Using an enum instead of a struct or class in such scenarios provides:

### Advantages

1. **Type Safety** — The compiler ensures only valid cases are used. Invalid states are impossible.
2. **Exhaustive Checking** — `switch` statements on enums must handle all cases, preventing missed scenarios.
3. **No Invalid State** — Unlike a struct with a `String` property (which could hold any string), an enum restricts values to defined cases.
4. **Associated Values** — Enums can carry different data for each case, making them more expressive than simple constants.
5. **Value Type & Lightweight** — Enums are value types, making them efficient for representing simple states.

### Example — When enum is better than struct/class

**Problem:** Represent the status of an order.

**Using a struct (fragile):**

```swift
struct OrderStatus {
    var status: String   // "pending", "shipped", "delivered" — but any string is allowed!
}

let s = OrderStatus(status: "pnding")  // typo — no compile error!
```

**Using an enum (safe):**

```swift
enum OrderStatus {
    case pending
    case shipped
    case delivered
    case cancelled
}

func handleOrder(status: OrderStatus) {
    switch status {
    case .pending:
        print("Order is being processed")
    case .shipped:
        print("Order is on the way")
    case .delivered:
        print("Order has arrived")
    case .cancelled:
        print("Order was cancelled")
    }
    // Compiler forces all cases to be handled — nothing is missed
}

handleOrder(status: .shipped)  // Order is on the way
// handleOrder(status: .pnding)  // ❌ Compile error — no such case
```

### When to prefer enum over struct/class

| Use Case | Best Choice |
|---|---|
| Fixed set of related values (e.g., directions, status) | **Enum** |
| Data with multiple properties (e.g., a student record) | **Struct / Class** |
| Need inheritance or reference semantics | **Class** |
| Represent state with associated data | **Enum with associated values** |

### Mental Model

Think of it this way:
- **Enum** = "it is one of these things" (a direction, a status, a payment method)
- **Struct** = "it has these properties" (a student, a coordinate, a rectangle)
- **Class** = "it has these properties AND I need identity/inheritance/reference sharing"
