# Module 1 — Introduction to Swift and Playgrounds (Practice Questions)

> Covers variables/constants, tuples, collections, control flow, enums, structs vs classes, error handling, and IBOutlet/IBAction.

---

## Q1. Explain the difference between `var` and `let` in Swift. What are type annotations and type inference? Provide examples.

### Answer

- **`let`** — Declares a **constant**. Its value cannot be changed after assignment.
- **`var`** — Declares a **variable**. Its value can be reassigned.

```swift
let pi = 3.14159
// pi = 3.14  // ❌ Compile error — cannot reassign a 'let' constant

var score = 90
score = 95     // ✅ Allowed
```

**Type Annotation** — Explicitly specifying the type:

```swift
let name: String = "Aman"
var age: Int = 20
var temperature: Double = 36.6
```

**Type Inference** — Swift automatically infers the type from the assigned value:

```swift
let name = "Aman"        // inferred as String
var age = 20             // inferred as Int
var temperature = 36.6   // inferred as Double
```

**When to use type annotations:**
- When there is no initial value: `var name: String`
- When you want a type different from the default: `var price: Float = 9.99` (without annotation, `9.99` would be `Double`)

**Best practice:** Prefer type inference when the type is obvious from the assigned value. Use annotations when the type would be ambiguous or when you want documentation-level clarity.

---

## Q2. What are tuples in Swift? How do you create and access elements of a tuple? Provide examples.

### Answer

A **tuple** groups multiple values of potentially different types into a single compound value.

### Creating and Accessing

```swift
// Unnamed tuple — access by index
let coordinates = (10, 20)
print(coordinates.0)  // 10
print(coordinates.1)  // 20

// Named tuple — access by name
let student = (name: "Aman", age: 20, grade: "A")
print(student.name)   // Aman
print(student.grade)  // A

// Decomposing a tuple
let (x, y) = coordinates
print(x)  // 10

// Ignoring a value with _
let (studentName, _, studentGrade) = student
print(studentName)   // Aman
```

**Returning a tuple from a function:**

```swift
func getMinMax(array: [Int]) -> (min: Int, max: Int) {
    var min = array[0], max = array[0]
    for value in array {
        if value < min { min = value }
        if value > max { max = value }
    }
    return (min, max)
}

let result = getMinMax(array: [3, 1, 7, 9])
print("Min: \(result.min), Max: \(result.max)")
// Min: 1, Max: 9
```

**When to use tuples vs other types:**
- Use tuples for **lightweight, temporary groupings** (e.g., returning multiple values from a function).
- Use structs when the group has **meaningful identity** or is reused across the codebase (e.g., a `Coordinate` struct instead of `(x: Int, y: Int)`).
- Tuples cannot conform to protocols or have methods — they are purely data containers.

---

## Q3. Differentiate between Arrays, Sets, and Dictionaries in Swift. Provide examples of creating and performing basic operations on each.

### Answer

| Feature | Array | Set | Dictionary |
|---|---|---|---|
| Order | Ordered | Unordered | Unordered |
| Duplicates | Allowed | Not allowed | Keys must be unique |
| Access | By index (`[0]`) | Membership test | By key (`["key"]`) |

### Array

```swift
var fruits: [String] = ["Apple", "Banana", "Apple"]
fruits.append("Mango")
print(fruits[0])          // Apple
print(fruits.count)       // 4
fruits.remove(at: 1)      // removes "Banana"
```

### Set

```swift
var colors: Set<String> = ["Red", "Green", "Blue", "Red"]
print(colors.count)              // 3 — duplicate removed
colors.insert("Yellow")
print(colors.contains("Green"))  // true
```

### Dictionary

```swift
var marks: [String: Int] = ["Aman": 85, "Riya": 92]
marks["Sunil"] = 78              // insert
marks["Riya"] = 95               // update
print(marks["Aman"]!)            // 85
marks.removeValue(forKey: "Sunil")
```

### Set Operations

Sets support powerful mathematical operations that arrays don't:

```swift
let setA: Set = [1, 2, 3, 4]
let setB: Set = [3, 4, 5, 6]

print(setA.union(setB))        // [1, 2, 3, 4, 5, 6]
print(setA.intersection(setB)) // [3, 4]
print(setA.subtracting(setB))  // [1, 2]
```

**Choosing the right collection:**
- **Array** — when order matters or duplicates are needed.
- **Set** — when you need uniqueness or fast lookups (`contains` is O(1) vs O(n) for arrays).
- **Dictionary** — when you need key-value associations.

---

## Q4. Explain the `switch` statement in Swift. How is it different from C/Java? Show examples with range matching, value binding, and the `where` clause.

### Answer

### Differences from C/Java

| Feature | Swift | C/Java |
|---|---|---|
| Fallthrough | No implicit fallthrough | Falls through; requires `break` |
| Exhaustive | Must cover all cases or have `default` | `default` is optional |
| Pattern matching | Ranges, tuples, `where` clause | Limited to equality |

### Basic Example

```swift
let grade = "B"
switch grade {
case "A": print("Excellent")
case "B": print("Good")
case "C": print("Average")
default:  print("Unknown")
}
// Output: Good
```

### Range Matching

```swift
let score = 85
switch score {
case 90...100: print("Grade A")
case 75..<90:  print("Grade B")
case 50..<75:  print("Grade C")
default:       print("Fail")
}
// Output: Grade B
```

### Value Binding + `where` Clause

```swift
let point = (3, -3)
switch point {
case let (x, y) where x == y:
    print("On the line x = y")
case let (x, y) where x == -y:
    print("On the line x = -y")
case let (x, y):
    print("Point (\(x), \(y))")
}
// Output: On the line x = -y
```

**Why Swift has no implicit fallthrough:** In C/Java, forgetting `break` causes bugs that are hard to spot. Swift eliminates this class of errors entirely. If you actually want fallthrough behavior, you must explicitly write `fallthrough` — making it intentional, not accidental.

---

## Q5. Explain `for-in` loops and the `stride` function in Swift. Provide examples.

### Answer

### `for-in` Loop

Iterates over a sequence — arrays, ranges, strings, dictionaries.

```swift
// Iterating over a range
for i in 1...5 {
    print(i)   // 1 2 3 4 5
}

// Iterating over an array
let fruits = ["Apple", "Banana", "Cherry"]
for fruit in fruits {
    print(fruit)
}

// Iterating over a dictionary
let marks = ["Aman": 85, "Riya": 92]
for (name, score) in marks {
    print("\(name) scored \(score)")
}

// Iterating over characters in a string
for char in "Swift" {
    print(char)   // S w i f t
}
```

### `stride` Function

Used when you need a custom step value or want to count backwards.

```swift
// stride(from:to:by:) — excludes the 'to' value
for i in stride(from: 0, to: 10, by: 2) {
    print(i)   // 0 2 4 6 8
}

// stride(from:through:by:) — includes the 'through' value
for i in stride(from: 10, through: 0, by: -3) {
    print(i)   // 10 7 4 1
}
```

---

## Q6. What are enums with raw values and associated values in Swift? How do they differ? Provide examples.

### Answer

### Raw Values

Each case is pre-assigned a **fixed, compile-time** value of the same type.

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars
    // venus = 2, earth = 3, mars = 4 (auto-incremented)
}

let p = Planet.earth
print(p.rawValue)       // 3

// Create from raw value (failable)
let planet = Planet(rawValue: 2)   // Optional(Planet.venus)
```

```swift
enum Direction: String {
    case north, south, east, west
}
print(Direction.north.rawValue)   // "north"
```

### Associated Values

Each case can carry **different data**, determined at **runtime**.

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qr(String)
}

let product1 = Barcode.upc(8, 85909, 51226, 3)
let product2 = Barcode.qr("ABCDEFG")

switch product1 {
case .upc(let a, let b, let c, let d):
    print("UPC: \(a)-\(b)-\(c)-\(d)")
case .qr(let code):
    print("QR: \(code)")
}
// Output: UPC: 8-85909-51226-3
```

### Differences

| Feature | Raw Values | Associated Values |
|---|---|---|
| Value type | Same type for all cases | Different types per case |
| When assigned | At compile time (fixed) | At runtime (per instance) |
| Access | `.rawValue` | Pattern matching (`switch`) |

**Real-world examples of associated values:**
- Network results: `.success(Data)` vs `.failure(Error)`
- UI actions: `.tap(at: CGPoint)` vs `.swipe(direction: Direction)`
- Payment methods: `.creditCard(number: String, expiry: String)` vs `.cash`

---

## Q7. What is the difference between a `struct` and a `class` in Swift? Provide an example demonstrating value type vs reference type behavior.

### Answer

| Feature | Struct | Class |
|---|---|---|
| Type | **Value type** | **Reference type** |
| Copying | Creates an independent copy | Creates a shared reference |
| Inheritance | Not supported | Supported |
| Memberwise init | Auto-generated | Not auto-generated |
| Deinitializer | Not supported | Supported (`deinit`) |
| Mutability | `mutating` needed to modify properties | Methods can modify freely |

**General guideline from Apple:** Use structs by default. Use classes only when you need inheritance, reference semantics (shared mutable state), or Objective-C interoperability.

### Value Type (Struct) — Independent Copies

```swift
struct Point {
    var x: Int
    var y: Int
}

var p1 = Point(x: 10, y: 20)
var p2 = p1          // p2 is an independent copy
p2.x = 99

print(p1.x)  // 10 — unchanged
print(p2.x)  // 99
```

### Reference Type (Class) — Shared Reference

```swift
class PointClass {
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

var c1 = PointClass(x: 10, y: 20)
var c2 = c1          // c2 points to the SAME object
c2.x = 99

print(c1.x)  // 99 — changed because c1 and c2 share the same object
print(c2.x)  // 99
```

---

## Q8. Explain error handling in Swift using `do-catch`, `try`, and `throw`. Provide an example.

### Answer

Swift's error handling uses four keywords: `throw`, `throws`, `try`, and `do-catch`.

**Step 1 — Define error types:**

```swift
enum LoginError: Error {
    case emptyUsername
    case emptyPassword
    case invalidCredentials
}
```

**Step 2 — Write a throwing function:**

```swift
func login(username: String, password: String) throws -> String {
    guard !username.isEmpty else { throw LoginError.emptyUsername }
    guard !password.isEmpty else { throw LoginError.emptyPassword }
    guard username == "admin" && password == "1234" else {
        throw LoginError.invalidCredentials
    }
    return "Login successful!"
}
```

**Step 3 — Call with `do-catch`:**

```swift
do {
    let message = try login(username: "admin", password: "1234")
    print(message)
} catch LoginError.emptyUsername {
    print("Username cannot be empty")
} catch LoginError.invalidCredentials {
    print("Invalid credentials")
} catch {
    print("Error: \(error)")
}
// Output: Login successful!
```

### Variants of `try`

| Keyword | Behavior |
|---|---|
| `try` | Must be inside `do-catch` |
| `try?` | Returns `nil` on error (no crash) |
| `try!` | Crashes if error is thrown |

**Practical tip:** Use `try?` when you don't care about the specific error and just want `nil` on failure (e.g., `let data = try? Data(contentsOf: url)`). Use `do-catch` when you need to handle different error types differently. Avoid `try!` in production code.

---

## Q9. Explain the role of IBOutlet and IBAction in UIKit with an example. How does Interface Builder connect UI elements to Swift code?

### Answer

- **`@IBOutlet`** — A property that references a UI element in the storyboard. Allows reading/modifying UI from code.
- **`@IBAction`** — A method triggered by a UI event (e.g., button tap).

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var greetingLabel: UILabel!

    @IBAction func greetButtonTapped(_ sender: UIButton) {
        greetingLabel.text = "Hello, Swift!"
    }
}
```

**How Interface Builder connects them:**

1. Open the Storyboard in Xcode.
2. **Ctrl-drag** from the UI element (e.g., a Label) to the code — Xcode creates an `@IBOutlet`.
3. **Ctrl-drag** from a Button to the code — Xcode creates an `@IBAction` method.
4. At runtime, UIKit uses these connections to update the UI and respond to events.

The filled circle (●) next to `@IBOutlet` or `@IBAction` in Xcode indicates a successful connection.
