# Set 1 — Fundamentals of Swift Programming

> This set covers IBOutlet/IBAction, closures, optional unwrapping, and struct initializers — all foundational UIKit and Swift concepts.

---

## Q1. Explain the role of IBOutlet and IBAction in UIKit. Provide an example of how they are used in a ViewController.

### Answer

**IBOutlet** and **IBAction** are special attributes used in UIKit to connect the user interface (designed in Interface Builder / Storyboard) to the Swift code in a ViewController.

- **`@IBOutlet`** — Creates a reference from the code to a UI element in the storyboard. It allows the programmer to read or modify the properties of a UI element (e.g., change a label's text, hide a button) from within the ViewController.
- **`@IBAction`** — Connects a UI event (such as a button tap) to a method in the ViewController. When the user interacts with the UI element, the linked method is automatically called.

**Key Points:**

- `@IBOutlet` is always declared as a property (usually a weak optional).
- `@IBAction` is always declared as a method.
- Both use the `@` prefix to indicate they are Interface Builder attributes.

### Example

```swift
import UIKit

class ViewController: UIViewController {

    // IBOutlet: connects to a UILabel in the storyboard
    @IBOutlet weak var greetingLabel: UILabel!

    // IBAction: connected to a UIButton tap event in the storyboard
    @IBAction func greetButtonTapped(_ sender: UIButton) {
        greetingLabel.text = "Hello, Swift!"
    }
}
```

**Explanation:**

1. `greetingLabel` is an `@IBOutlet` that references a `UILabel` on the storyboard. We can read or modify its `text` property from the code.
2. `greetButtonTapped(_:)` is an `@IBAction` method connected to a button's "Touch Up Inside" event. When the user taps the button, this method executes and updates the label's text to "Hello, Swift!".

### How It Works Under the Hood

When you Ctrl-drag from a UI element to your code, Xcode stores the connection in the storyboard's XML. At runtime, UIKit reads the storyboard, creates the UI objects, and uses **Key-Value Coding (KVC)** to wire each `@IBOutlet` property to the corresponding UI element. This is why outlets are declared as **implicitly unwrapped optionals (`!`)** — they are `nil` until the storyboard finishes loading, but are guaranteed to exist by the time `viewDidLoad()` runs.

### Common Mistakes

- **Disconnected outlet:** If you delete an `@IBOutlet` in code but forget to remove the connection in the storyboard, the app crashes at launch with `"this class is not key value coding-compliant"`.
- **Multiple connections:** Accidentally Ctrl-dragging twice creates duplicate connections, which can cause unexpected behavior.
- **Forgetting `weak`:** Outlets should be `weak` to avoid retain cycles, since the view hierarchy already holds a strong reference to the element.

---

## Q2. What are Closures in Swift? How are they different from regular functions? Provide an example.

### Answer

A **closure** is a self-contained block of functionality that can be passed around and used in code. Closures in Swift are similar to lambdas or anonymous functions in other languages.

**Definition:** Closures are unnamed (anonymous) blocks of code that can capture and store references to variables and constants from the surrounding context in which they are defined. This is called **capturing values**.

### Differences between Closures and Functions

| Feature | Function | Closure |
|---|---|---|
| Name | Has a name | Can be anonymous (unnamed) |
| Keyword | Defined with `func` | Defined with `{ }` syntax |
| Argument labels | Has argument labels by default | Does not use argument labels |
| Shorthand | No shorthand forms | Supports shorthand argument names (`$0`, `$1`) |
| Capturing | Does not capture surrounding values | Captures values from enclosing scope |

> **Note:** In Swift, functions are actually a special case of closures. Every function is a closure, but not every closure is a function.

**Why closures matter in iOS:** Closures are used extensively for callbacks (e.g., completion handlers in network calls), animations (`UIView.animate { ... }`), and array operations (`map`, `filter`, `reduce`). Understanding them is essential for iOS development.

### Example

```swift
// Regular function
func addFunction(a: Int, b: Int) -> Int {
    return a + b
}
let result1 = addFunction(a: 3, b: 5)  // 8

// Closure (anonymous function)
let addClosure: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
}
let result2 = addClosure(3, 5)  // 8

// Closure with shorthand argument names
let multiplyClosure: (Int, Int) -> Int = { $0 * $1 }
let result3 = multiplyClosure(4, 5)  // 20
```

**Closures capturing values:**

Closures can **capture and remember** variables from their surrounding context. Even after the enclosing function returns, the closure retains access to those variables.

```swift
func makeCounter() -> () -> Int {
    var count = 0
    let counter: () -> Int = {
        count += 1       // captures 'count' from enclosing scope
        return count
    }
    return counter
}

let counter = makeCounter()
print(counter())  // 1
print(counter())  // 2 — 'count' persists across calls
```

Notice that `count` is a **local variable** inside `makeCounter()`, yet the closure keeps it alive. Each call to `makeCounter()` creates a **new, independent** `count`:

```swift
let counterA = makeCounter()
let counterB = makeCounter()
print(counterA())  // 1
print(counterA())  // 2
print(counterB())  // 1 — independent copy
```

### Memory Consideration

Closures are **reference types**. When a closure captures `self` inside a class, it can create a **retain cycle** (memory leak). Use `[weak self]` or `[unowned self]` in the capture list to avoid this:

```swift
// Inside a class method:
someFunctionWithClosure { [weak self] in
    self?.doSomething()   // safe — won't create a retain cycle
}
```

---

## Q3. What is the difference between optional binding and forced unwrapping in Swift? When should each be used? Provide an example of both.

### Answer

In Swift, an **optional** is a type that can hold either a value or `nil`. Unlike many other languages (C, Java, JavaScript), Swift **does not allow** regular (non-optional) variables to be `nil`. This eliminates an entire class of bugs — null pointer exceptions — by making the programmer explicitly handle the possibility of missing data.

To access the value inside an optional, we need to **unwrap** it. There are two main ways to do this:

### 1. Optional Binding (`if let` / `guard let`)

Optional binding safely checks whether an optional contains a value. If it does, the value is made available as a temporary constant or variable.

- **Safe** — the code inside the block runs only if the optional is not `nil`.
- **Should be used** when you are unsure whether the optional contains a value.

```swift
let name: String? = "Swift"

if let unwrappedName = name {
    print("Hello, \(unwrappedName)")   // prints: Hello, Swift
} else {
    print("Name is nil")
}
```

### 2. Forced Unwrapping (`!`)

Forced unwrapping uses the `!` operator to directly extract the value from an optional.

- **Unsafe** — if the optional is `nil`, the program will crash with a runtime error.
- **Should be used** only when you are absolutely certain the optional contains a value.

```swift
let name: String? = "Swift"
print("Hello, \(name!)")   // prints: Hello, Swift

// Danger: if name were nil, this would crash
let emptyName: String? = nil
// print(emptyName!)  // ❌ Runtime crash: unexpectedly found nil
```

### Comparison

| Feature | Optional Binding | Forced Unwrapping |
|---|---|---|
| Syntax | `if let` / `guard let` | `!` operator |
| Safety | Safe — handles `nil` gracefully | Unsafe — crashes on `nil` |
| When to use | When the value might be `nil` | Only when you are 100% sure the value exists |

### Practical Advice

- **Default to `if let` or `guard let`** — these should be your go-to approach.
- **Use `??` (nil-coalescing)** when you have a sensible default value (e.g., `username ?? "Guest"`).
- **Avoid `!` (forced unwrapping)** in production code. It is acceptable in unit tests or when you are truly guaranteed a value (e.g., hardcoded resource loading).
- **Use `guard let` over `if let`** when you need the unwrapped value for the rest of the function — it avoids deep nesting and keeps the happy path clear.

---

## Q4. What are initializers in Swift structs? Explain the difference between a memberwise initializer and a custom initializer with an example.

### Answer

An **initializer** is a special method that is called when a new instance of a struct (or class) is created. Its purpose is to ensure all stored properties have valid values before the instance is used. Initializers are defined using the `init` keyword.

Swift enforces **safety by design** — you cannot use an instance until all its stored properties have been assigned a value. Initializers are the mechanism that guarantees this.

### 1. Memberwise Initializer

Swift automatically provides a **memberwise initializer** for structs. This initializer has parameters corresponding to each stored property of the struct, in the order they are declared.

- It is generated automatically — the programmer does not need to write it.
- It is only available if the programmer has **not** defined a custom initializer.

```swift
struct Student {
    var name: String
    var age: Int
}

// Using the auto-generated memberwise initializer
let s1 = Student(name: "Aman", age: 20)
print(s1.name)  // Aman
print(s1.age)   // 20
```

### 2. Custom Initializer

A **custom initializer** is written by the programmer to provide additional logic during initialization, such as setting default values, validating input, or computing initial property values.

- When a custom initializer is defined, the automatic memberwise initializer is **no longer available** (unless the custom initializer is placed in an extension).

```swift
struct Student {
    var name: String
    var age: Int

    // Custom initializer with a default age
    init(name: String) {
        self.name = name
        self.age = 18   // default value
    }

    // Another custom initializer
    init(name: String, birthYear: Int) {
        self.name = name
        self.age = 2026 - birthYear
    }
}

let s1 = Student(name: "Aman")
print(s1.age)  // 18

let s2 = Student(name: "Riya", birthYear: 2004)
print(s2.age)  // 22
```

### Key Differences

| Feature | Memberwise Initializer | Custom Initializer |
|---|---|---|
| Provided by | Swift (automatically) | Programmer (manually) |
| Parameters | One per stored property | Defined by the programmer |
| Logic | Simple assignment | Can include defaults, validation, computation |
| Availability | Only if no custom `init` is defined | Always available when explicitly written |

### Tip: Keep Both Initializers Using an Extension

If you define a custom `init` inside the struct, Swift removes the memberwise initializer. To keep **both**, put the custom initializer in an **extension**:

```swift
struct Student {
    var name: String
    var age: Int
}

extension Student {
    init(name: String) {
        self.name = name
        self.age = 18
    }
}

let s1 = Student(name: "Aman", age: 20)  // ✅ memberwise — still works
let s2 = Student(name: "Riya")            // ✅ custom — also works
```

This is a common Swift pattern — it gives you the flexibility of custom initialization without losing the convenience of the auto-generated one.
