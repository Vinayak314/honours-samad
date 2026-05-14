# Module 2 — Functions, Subscripts, Extensions (Practice Questions)

> Covers variadic/inout parameters, function types, trailing closures, operators as functions, extensions, protocol extensions, subscripts, and @autoclosure/@escaping.

---

## Q1. What are variadic parameters and inout parameters in Swift functions? Explain with examples.

### Answer

### Variadic Parameters

A variadic parameter accepts **zero or more values** of a specified type, received as an **array** inside the function. Defined by appending `...` after the type.

```swift
func average(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

print(average(10, 20, 30))     // 20.0
print(average(5, 15, 25, 35))  // 20.0
```

### Inout Parameters

By default, function parameters are constants. An **`inout`** parameter lets the function **modify the caller's original variable**. The caller must prefix the argument with `&`.

```swift
func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var x = 10, y = 20
swapValues(&x, &y)
print("x = \(x), y = \(y)")   // x = 20, y = 10
```

| Feature | Variadic | Inout |
|---|---|---|
| Syntax | `Type...` | `inout Type` |
| Caller syntax | Comma-separated values | `&variable` |
| Purpose | Accept multiple values | Modify the original variable |

**Key detail about `inout`:** The `&` prefix warns the caller: "this function will modify my variable." This is intentional — Swift makes side effects visible at the call site so you always know when a function might change your data.

**Limitation:** You cannot pass a `let` constant or a literal as an `inout` argument — only `var` variables.

---

## Q2. What are function types in Swift? Explain how functions can be passed as parameters and returned from other functions.

### Answer

Every function has a **type** defined by its parameter and return types.

```swift
func add(_ a: Int, _ b: Int) -> Int { return a + b }
// Type: (Int, Int) -> Int

func greet() { print("Hello") }
// Type: () -> Void
```

**Storing a function in a variable:**

```swift
var operation: (Int, Int) -> Int = add
print(operation(3, 5))   // 8
```

### Passing a Function as a Parameter

```swift
func multiply(_ a: Int, _ b: Int) -> Int { return a * b }

func calculate(_ a: Int, _ b: Int, using op: (Int, Int) -> Int) -> Int {
    return op(a, b)
}

print(calculate(4, 5, using: add))       // 9
print(calculate(4, 5, using: multiply))  // 20
```

### Returning a Function

```swift
func makeIncrementer(by amount: Int) -> (Int) -> Int {
    func incrementer(number: Int) -> Int {
        return number + amount
    }
    return incrementer
}

let addFive = makeIncrementer(by: 5)
print(addFive(10))   // 15
print(addFive(20))   // 25
```

**Why this matters:** Functions as first-class citizens is what enables Swift's powerful functional programming patterns — `map`, `filter`, `reduce`, completion handlers, strategy pattern, and dependency injection all rely on this capability.

---

## Q3. What is trailing closure syntax in Swift? When is it used? Provide examples.

### Answer

If the **last parameter** of a function is a closure, the closure can be written **after the parentheses**. This is trailing closure syntax.

### Without vs With Trailing Closure

```swift
let numbers = [3, 1, 4, 1, 5]

// Without trailing closure
let sorted1 = numbers.sorted(by: { $0 < $1 })

// With trailing closure
let sorted2 = numbers.sorted { $0 < $1 }
```

### Using with `map` and `filter`

```swift
let names = ["aman", "riya", "sunil"]
let upper = names.map { $0.uppercased() }
print(upper)   // ["AMAN", "RIYA", "SUNIL"]

let numbers = [10, 25, 30, 65]
let aboveThirty = numbers.filter { $0 > 30 }
print(aboveThirty)   // [65]
```

### Custom function with trailing closure

```swift
func repeatAction(times: Int, action: () -> Void) {
    for _ in 1...times {
        action()
    }
}

repeatAction(times: 3) {
    print("Hello!")
}
// Hello! Hello! Hello!
```

**Rule:** If the closure is the **only** argument, parentheses can be omitted:

```swift
let doubled = [1, 2, 3].map { $0 * 2 }   // [2, 4, 6]
```

**When to use trailing closure syntax:**
- **Always use it** when the closure is the primary purpose of the function call (e.g., `map`, `filter`, animations).
- **Avoid it** when there are multiple closures — it can make the code harder to read.
- Swift 5.3+ supports **multiple trailing closures** for APIs like `UIView.animate(withDuration:animations:completion:)`.

---

## Q4. Explain how operators are functions in Swift. Provide an example of using an operator as a function argument.

### Answer

In Swift, **operators like `+`, `<`, `*` are actually functions**. They have a function type and can be passed as arguments wherever a function of that type is expected.

For example, the `<` operator has the type `(Int, Int) -> Bool`.

### Example — Using an operator as a function argument

```swift
let numbers = [5, 3, 8, 1, 4]

// The sorted(by:) method expects a function of type (Int, Int) -> Bool
// The < operator matches this type
let ascending = numbers.sorted(by: <)
print(ascending)   // [1, 3, 4, 5, 8]

let descending = numbers.sorted(by: >)
print(descending)  // [8, 5, 4, 3, 1]
```

### Another example — Using `+` as a function

```swift
let values = [1, 2, 3, 4, 5]

// reduce expects an initial value and a function of type (Int, Int) -> Int
// The + operator matches that type
let sum = values.reduce(0, +)
print(sum)   // 15
```

This works because `+` is a function of type `(Int, Int) -> Int`, which matches the parameter type expected by `reduce`.

---

## Q5. What are extensions in Swift? How can you add computed properties, methods, and initializers using extensions? Provide examples.

### Answer

An **extension** adds new functionality to an existing type (class, struct, enum, or protocol) **without modifying its original source code**. Extensions can add:

- Computed properties
- Methods
- New initializers
- Subscripts
- Protocol conformance

> **Note:** Extensions **cannot** add stored properties or override existing functionality.

**Why extensions are powerful:** They let you add functionality to types you don't own — including built-in types like `Int`, `String`, `Double`, and even third-party library types. This is how Swift achieves "retroactive modeling" — making existing types conform to new protocols without modifying their source code.

### Adding a Computed Property

```swift
extension Double {
    var km: Double { return self * 1000.0 }
    var cm: Double { return self / 100.0 }
}

print(5.0.km)    // 5000.0
print(150.0.cm)  // 1.5
```

### Adding a Method

```swift
extension Int {
    func squared() -> Int {
        return self * self
    }

    mutating func cube() {
        self = self * self * self
    }
}

print(4.squared())   // 16

var num = 3
num.cube()
print(num)           // 27
```

### Adding an Initializer

Extensions can add **convenience initializers** to types. This is especially useful for structs because you can add custom initializers without losing the auto-generated memberwise initializer.

```swift
struct Rect {
    var width: Double
    var height: Double
}

extension Rect {
    // Custom init in extension — memberwise init is still available!
    init(side: Double) {
        self.width = side
        self.height = side
    }
}

let r1 = Rect(width: 10, height: 20)  // memberwise init — still works
let r2 = Rect(side: 15)                // custom init from extension
print(r2.width)   // 15.0
```

---

## Q6. What are protocol extensions in Swift? How do they provide default implementations? Provide an example.

### Answer

A **protocol extension** extends a protocol to provide **default implementations** of its methods or computed properties. Any type conforming to the protocol automatically gets these defaults, but can override them if needed.

### Example

```swift
protocol Describable {
    var description: String { get }
    func summarize() -> String
}

// Protocol extension with default implementations
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

struct Movie: Describable {
    var title: String
    var description: String {
        return "Movie: \(title)"
    }
    // Override the default implementation
    func summarize() -> String {
        return "🎬 \(description)"
    }
}

let book = Book(title: "Swift Programming")
print(book.summarize())   // Description: Book: Swift Programming

let movie = Movie(title: "Inception")
print(movie.summarize())  // 🎬 Movie: Inception
```

### Key Points

- Protocol extensions let you write **shared functionality once** instead of in every conforming type.
- Conforming types **can override** the default implementation.
- You can constrain extensions: `extension Collection where Element: Equatable { ... }`

**Practical impact:** Protocol extensions are the foundation of **protocol-oriented programming** in Swift. They allow you to write shared behavior once and have it automatically available to all conforming types — achieving code reuse without inheritance.

---

## Q7. What are subscripts in Swift? Explain the syntax for defining read-only and read-write subscripts. Provide examples.

### Answer

**Subscripts** allow instances to be accessed using square-bracket syntax (`[]`), like arrays and dictionaries.

### Read-Write Subscript

```swift
struct Matrix {
    var data: [[Int]]

    subscript(row: Int, col: Int) -> Int {
        get {
            return data[row][col]
        }
        set {
            data[row][col] = newValue
        }
    }
}

var m = Matrix(data: [[1, 2], [3, 4]])
print(m[0, 1])   // 2
m[1, 0] = 99
print(m[1, 0])   // 99
```

### Read-Only Subscript

Omit the `set` block. The `get` keyword can also be omitted for brevity.

```swift
struct TimesTable {
    var multiplier: Int

    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let table = TimesTable(multiplier: 7)
print(table[3])   // 21
print(table[6])   // 42
// table[3] = 10  // ❌ Compile error — read-only
```

| Feature | Read-Only | Read-Write |
|---|---|---|
| `get` block | Required (can be implicit) | Required |
| `set` block | Absent | Required |

---

## Q8. What are `@autoclosure` and `@escaping` closures in Swift? Explain with examples.

### Answer

### `@autoclosure`

Automatically wraps an expression into a closure. The caller writes a plain expression instead of `{ expression }`.

```swift
func logIfTrue(_ condition: @autoclosure () -> Bool) {
    if condition() {
        print("Condition is true")
    }
}

logIfTrue(5 > 3)   // No braces needed — expression wrapped automatically
// Output: Condition is true
```

**Use case:** Deferred evaluation — the expression is only evaluated when the closure is called. Used in `assert()`, `??`, etc.

### `@escaping`

A closure is **escaping** if it outlives the function that receives it (e.g., stored in a property, called after the function returns). It must be marked `@escaping`.

```swift
var completionHandlers: [() -> Void] = []

func addHandler(handler: @escaping () -> Void) {
    completionHandlers.append(handler)   // stored for later use
}

addHandler {
    print("Task completed!")
}

// Called later
completionHandlers[0]()   // Task completed!
```

| Feature | `@autoclosure` | `@escaping` |
|---|---|---|
| Purpose | Auto-wraps expression in closure | Allows closure to outlive function |
| Caller difference | Writes plain expression | Writes normal closure |
| Common use | `assert()`, `??` | Async callbacks, stored closures |

**Memory note on `@escaping`:** Since escaping closures outlive the function, they can create retain cycles if they capture `self` inside a class. Always use `[weak self]` or `[unowned self]` in the capture list for escaping closures that reference `self`:

```swift
func fetchData(completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        completion()
    }
}

// Inside a class:
fetchData { [weak self] in
    self?.updateUI()   // safe — no retain cycle
}
```
