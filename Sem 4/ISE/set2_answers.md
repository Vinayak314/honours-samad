# Set 2 — Fundamentals of Swift Programming

> This set covers if-let vs guard, @autoclosure, enum properties/methods, and failable initializers.

---

## Q1. Differentiate between if-let and guard statements in Swift when handling optionals. Provide an example for each.

### Answer

Both `if let` and `guard let` are used for **optional binding** — safely unwrapping optionals. They differ in control flow and scope.

### `if let`

- Unwraps the optional inside a **new scope** (the `if` block).
- The unwrapped value is available **only inside** the braces.
- Used when the optional value is needed for a limited block of code.

```swift
func greetUser(name: String?) {
    if let unwrappedName = name {
        print("Hello, \(unwrappedName)")
    } else {
        print("Name is nil")
    }
    // unwrappedName is NOT accessible here
}

greetUser(name: "Aman")   // Hello, Aman
greetUser(name: nil)       // Name is nil
```

### `guard let`

- Unwraps the optional and makes the value available in the **remaining scope** of the function.
- The `else` block must **exit** the current scope (using `return`, `break`, `throw`, etc.).
- Used for **early exit** — validates preconditions at the top of a function.

```swift
func greetUser(name: String?) {
    guard let unwrappedName = name else {
        print("Name is nil")
        return   // must exit the scope
    }
    // unwrappedName is accessible here and below
    print("Hello, \(unwrappedName)")
}

greetUser(name: "Riya")   // Hello, Riya
greetUser(name: nil)       // Name is nil
```

### Key Differences

| Feature | `if let` | `guard let` |
|---|---|---|
| Scope of unwrapped value | Inside the `if` block only | Rest of the enclosing function/scope |
| `else` block requirement | Optional | Mandatory (must exit scope) |
| Best used for | Short, optional code paths | Early exit / precondition checks |
| Code readability | Can lead to nesting | Keeps the "happy path" un-indented |

### When to Use Which

- **Use `if let`** when you only need the unwrapped value for a small block of code, or when you want to handle both the `some` and `nil` cases equally.
- **Use `guard let`** when you have **preconditions** that must be met before the rest of the function can proceed. It's the idiomatic Swift way to validate inputs at the top of a function.
- **Rule of thumb:** If the `else` case means "stop and exit," use `guard`. If both paths are equally important, use `if let`.

---

## Q2. What is @autoclosure in Swift? How does it work, and in what scenarios is it useful? Provide an example.

### Answer

**`@autoclosure`** is a Swift attribute that automatically wraps an expression in a closure. The caller writes a simple expression, but the function receives it as a closure that can be evaluated later (or not at all).

**How it works:**

- Without `@autoclosure`, the caller must explicitly pass `{ expression }`.
- With `@autoclosure`, the caller simply writes `expression`, and Swift wraps it in `{ }` automatically.

**When it is useful:**

1. **Deferred evaluation** — the expression is evaluated only when the closure is called, not when the function is invoked. This is useful for expensive computations that may not always be needed.
2. **Cleaner syntax** — removes the need for braces at the call site.
3. **Used in standard library** — `assert()`, `precondition()`, and the `??` (nil-coalescing) operator use `@autoclosure` to avoid evaluating the expression unless necessary.

### Example

```swift
// Without @autoclosure
func logMessage(message: () -> String) {
    print("LOG: \(message())")
}
logMessage(message: { "Something happened" })  // caller must use { }

// With @autoclosure
func logMessage(message: @autoclosure () -> String) {
    print("LOG: \(message())")
}
logMessage(message: "Something happened")  // cleaner call site
```

**Practical example — deferred evaluation:**

```swift
func validateAge(age: Int, errorMessage: @autoclosure () -> String) {
    if age < 18 {
        print(errorMessage())   // evaluated only if age < 18
    } else {
        print("Access granted")
    }
}

validateAge(age: 15, errorMessage: "Age \(15) is below 18")
// prints: Age 15 is below 18

validateAge(age: 20, errorMessage: "This string is never created")
// prints: Access granted
```

In the second call, the error message string is **never constructed** because the closure is never invoked, saving computation.

### Key Takeaways

- `@autoclosure` is a **caller convenience** — it simplifies the call site by removing braces.
- The main benefit is **lazy/deferred evaluation** — the expression isn't computed unless the closure is actually called.
- **Don't overuse it** — it hides the fact that an expression is wrapped in a closure, which can make code harder to read. Use it only when the deferred evaluation pattern is intentional.
- The Swift standard library uses it in `assert()`, `precondition()`, and `??` — this is why `assert(someExpensiveCheck())` doesn't slow down release builds (the closure is never called when assertions are disabled).

---

## Q3. How can an enum have computed properties and methods in Swift? Provide an example.

### Answer

In Swift, **enums are first-class types** — they are far more powerful than enums in C or Java. Swift enums can have:

- **Computed properties** — properties that calculate a value based on the current case.
- **Methods** — functions defined inside the enum.
- **Mutating methods** — methods that can change `self` to a different case.
- **Static methods** — type-level utility functions.
- **Subscripts** and **protocol conformance.**

> **Note:** Enums **cannot** have stored properties, but computed properties are allowed because they don't store a value — they compute it on the fly.

This makes enums ideal for encapsulating behavior alongside related states — instead of using external `switch` statements everywhere, you put the logic inside the enum itself.

### Example

```swift
enum Direction {
    case north, south, east, west

    // Computed property
    var opposite: Direction {
        switch self {
        case .north: return .south
        case .south: return .north
        case .east:  return .west
        case .west:  return .east
        }
    }

    // Method
    func description() -> String {
        switch self {
        case .north: return "Heading North"
        case .south: return "Heading South"
        case .east:  return "Heading East"
        case .west:  return "Heading West"
        }
    }
}

let dir = Direction.north
print(dir.opposite)       // south
print(dir.description())  // Heading North
```

**Enum with associated values, computed property and method:**

```swift
enum Shape {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)

    // Computed property
    var area: Double {
        switch self {
        case .circle(let r):
            return Double.pi * r * r
        case .rectangle(let w, let h):
            return w * h
        }
    }

    // Method
    func describe() -> String {
        switch self {
        case .circle(let r):
            return "Circle with radius \(r), area = \(area)"
        case .rectangle(let w, let h):
            return "Rectangle \(w)x\(h), area = \(area)"
        }
    }
}

let s = Shape.circle(radius: 5)
print(s.area)        // 78.539...
print(s.describe())  // Circle with radius 5.0, area = 78.539...
```

### Why This Pattern Is Powerful

By putting `area` and `describe()` inside the enum, **adding a new shape requires updating only one place** — the enum itself. If these were external functions with `switch` statements scattered across the codebase, adding a new case would require finding and updating every single switch. This is the **Open-Closed Principle** in action.

---

## Q4. What are failable initializers in Swift structs? Explain with an example.

### Answer

A **failable initializer** is an initializer that can return `nil` if the initialization fails. It is defined using `init?` (with a question mark). This is useful when the input values may be invalid and creating an instance would not make sense.

**Why it matters:** In many real-world scenarios, not all inputs are valid. Rather than creating an object in an invalid state and hoping someone checks later, a failable initializer **prevents invalid objects from ever existing**. This is a core Swift philosophy — make illegal states unrepresentable.

**Key Points:**

- Defined with `init?` instead of `init`.
- Returns an **optional** instance (`Type?`).
- Returns `nil` inside the initializer body if validation fails.
- The caller must handle the optional result (using `if let`, `guard let`, etc.).

### Example

```swift
struct Student {
    var name: String
    var percentage: Double

    // Failable initializer
    init?(name: String, percentage: Double) {
        // Validation: percentage must be between 0 and 100
        if percentage < 0 || percentage > 100 {
            return nil   // initialization fails
        }
        self.name = name
        self.percentage = percentage
    }
}

// Successful initialization
if let s1 = Student(name: "Aman", percentage: 85.5) {
    print("\(s1.name) scored \(s1.percentage)%")  // Aman scored 85.5%
} else {
    print("Invalid data")
}

// Failed initialization
if let s2 = Student(name: "Riya", percentage: 150) {
    print("\(s2.name) scored \(s2.percentage)%")
} else {
    print("Invalid data")  // This prints because 150 is out of range
}
```

**Another example — parsing a string to create an instance:**

```swift
struct Temperature {
    var celsius: Double

    init?(fromString str: String) {
        guard let value = Double(str) else {
            return nil   // string is not a valid number
        }
        self.celsius = value
    }
}

let t1 = Temperature(fromString: "36.6")   // Optional(Temperature(celsius: 36.6))
let t2 = Temperature(fromString: "hot")     // nil
```

### Real-World Use Cases

- **Parsing user input:** `Int("abc")` returns `nil` — `Int.init` is itself a failable initializer.
- **Loading resources:** `UIImage(named: "icon")` returns `nil` if the image doesn't exist.
- **Creating URLs:** `URL(string: "not a url")` returns `nil` for invalid strings.
- **Model validation:** Ensuring API responses have required fields before creating model objects.

### `init?` vs `init` — When to Choose

| Scenario | Use |
|---|---|
| All inputs are always valid | Regular `init` |
| Input might be invalid or out of range | Failable `init?` |
| Invalid input should crash (programmer mistake) | `init` with `precondition()` |
