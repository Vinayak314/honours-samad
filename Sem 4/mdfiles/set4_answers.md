# Set 4 — Fundamentals of Swift Programming

> This set covers property observers (willSet/didSet), subscripts (read-only and read-write), and the `mutating` keyword in structs.

---

## Q1. Explain the purpose and syntax of property observers in Swift. Explain the significance of newValue in willSet and oldValue in didSet.

### Answer

### Purpose

**Property observers** allow you to monitor and respond to changes in a stored property's value. They are used to execute custom code whenever a property is about to be changed or has just been changed. Common uses include:

- Logging value changes
- Validating new values
- Updating the UI when data changes
- Triggering dependent computations

### Syntax

```swift
var propertyName: Type = initialValue {
    willSet {
        // code that runs BEFORE the value changes
        // 'newValue' is available here
    }
    didSet {
        // code that runs AFTER the value changes
        // 'oldValue' is available here
    }
}
```

### Significance of `newValue` and `oldValue`

- **`newValue` in `willSet`:** This is an implicit constant that holds the **value that is about to be assigned** to the property. It allows you to inspect or log the incoming value before the change takes effect. You can also give it a custom name: `willSet(incomingValue)`.

- **`oldValue` in `didSet`:** This is an implicit constant that holds the **previous value** of the property (the value it had before the change). It allows you to compare the old and new values or take action based on what changed. You can also give it a custom name: `didSet(previousValue)`.

### Example

```swift
struct BankAccount {
    var balance: Double = 0.0 {
        willSet {
            print("Balance will change from \(balance) to \(newValue)")
            // 'newValue' is the value about to be assigned
        }
        didSet {
            let difference = balance - oldValue
            // 'oldValue' is the value before the change
            if difference > 0 {
                print("Deposited: +\(difference)")
            } else {
                print("Withdrawn: \(difference)")
            }
        }
    }
}

var account = BankAccount()
account.balance = 1000
// Output:
// Balance will change from 0.0 to 1000.0
// Deposited: +1000.0

account.balance = 750
// Output:
// Balance will change from 1000.0 to 750.0
// Withdrawn: -250.0
```

### Custom names for newValue and oldValue

```swift
var score: Int = 0 {
    willSet(incomingScore) {
        print("Score will become \(incomingScore)")
    }
    didSet(previousScore) {
        print("Score was \(previousScore), now is \(score)")
    }
}
```

> **Note:** Property observers are **not called during initialization** — they are triggered only when the property is set after the instance has been fully initialized. This is intentional: during `init`, the object is still being set up, so firing observers could lead to using an object that isn't fully ready.

### Practical Tips

- **`didSet` is used more often** than `willSet` in practice, because you usually want to react **after** the change (e.g., update a label, save to disk).
- You can **modify the property inside `didSet`** without re-triggering the observer (Swift prevents infinite loops).
- Property observers work on **stored properties only** — computed properties don't need them because you control the getter and setter directly.

---

## Q2. Explain the concept of subscripts in Swift. Describe the syntax for defining both read-only and read-write subscripts within a custom type.

### Answer

### Concept

A **subscript** allows instances of a class, struct, or enum to be accessed using the square bracket syntax (`[]`). Subscripts are shortcuts for accessing elements of a collection, list, or custom data structure without needing separate getter and setter methods.

For example, `array[0]` and `dictionary["key"]` both use subscripts internally.

You can define your own subscripts in custom types to provide intuitive element access.

### Syntax — Read-Write Subscript

A read-write subscript has both a `get` and a `set` block.

```swift
struct CustomCollection {
    var data: [String]

    subscript(index: Int) -> String {
        get {
            return data[index]      // return the element
        }
        set(newValue) {
            data[index] = newValue  // set the element
        }
    }
}

var collection = CustomCollection(data: ["A", "B", "C"])
print(collection[1])      // "B" — uses getter
collection[1] = "Z"       // uses setter
print(collection[1])      // "Z"
```

### Syntax — Read-Only Subscript

A read-only subscript only provides a `get` block. The `get` keyword can be omitted for brevity.

```swift
struct TimesTable {
    var multiplier: Int

    // Read-only subscript (shorthand — no 'get' keyword needed)
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print(threeTimesTable[4])   // 12
print(threeTimesTable[7])   // 21

// threeTimesTable[4] = 10  // ❌ Compile error — subscript is read-only
```

### Comparison

| Feature | Read-Only Subscript | Read-Write Subscript |
|---|---|---|
| `get` block | Required (can be implicit) | Required |
| `set` block | Not present | Required |
| Usage | Can only read values | Can read and write values |
| Syntax shorthand | Can omit `get { }` wrapper | Must have both `get { }` and `set { }` |

### Design Consideration

Subscripts should be used when square bracket access **feels natural** for your type. If your type conceptually wraps a collection, grid, or lookup table, subscripts make the API intuitive. For unrelated operations, regular methods are clearer.

Examples from Swift's standard library:
- `array[0]` — access by index
- `dictionary["key"]` — access by key
- `string[string.startIndex]` — access by string index

### Subscripts with Multiple Parameters

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

---

## Q3. Explain why methods within a Swift struct need to be explicitly marked with the mutating keyword. What fundamental characteristic of structs necessitates this keyword? Provide a simple code example.

### Answer

### Fundamental Characteristic — Structs are Value Types

In Swift, **structs are value types**. This means:

- When a struct is assigned to a variable or passed to a function, a **copy** is made.
- By default, the properties of a struct **cannot be modified** from within its own methods. This is because `self` is treated as an **immutable constant** inside a struct's methods.

This is fundamentally different from classes, which are **reference types** — their methods can freely modify properties because all references point to the same object in memory.

### Why `mutating` is Required

Since `self` is immutable by default inside a struct method, any method that wants to **change a stored property** must be explicitly marked with the **`mutating`** keyword. This tells the Swift compiler:

1. This method is **allowed to modify** `self` and its properties.
2. Behind the scenes, the mutating method creates a **new copy of the struct** with the modified values and assigns it back to the original variable.

> **Note:** You cannot call a `mutating` method on a struct instance that is declared with `let`, because constants cannot be changed.

**Analogy:** Think of a struct as a piece of paper with values written on it. When you call a `mutating` method, you're not erasing and rewriting on the same paper — you're creating a **new piece of paper** with the updated values and replacing the old one. That's why `let` instances can't use mutating methods: you've said "this paper is final."

### Code Example

```swift
struct Counter {
    var count: Int = 0

    // This method modifies 'count', so it must be marked 'mutating'
    mutating func increment() {
        count += 1
    }

    mutating func reset() {
        count = 0
    }

    // This method only reads properties — no 'mutating' needed
    func displayCount() {
        print("Count is \(count)")
    }
}

var myCounter = Counter()
myCounter.increment()
myCounter.increment()
myCounter.displayCount()  // Count is 2

myCounter.reset()
myCounter.displayCount()  // Count is 0

// With 'let', mutating methods cannot be called:
let fixedCounter = Counter()
// fixedCounter.increment()  // ❌ Compile error — cannot mutate a 'let' constant
```

### Summary

| Aspect | Explanation |
|---|---|
| Structs are value types | Properties are immutable by default inside methods |
| `mutating` keyword | Grants permission to modify stored properties within the method |
| Behind the scenes | A new copy of the struct replaces the original |
| `let` instances | Cannot call `mutating` methods — the instance is fully immutable |
| Classes | Do **not** need `mutating` because they are reference types |

### Why This Design Choice?

Swift makes mutation **explicit** to avoid hidden side effects. In a large codebase, knowing that a method **won't** modify the struct (because it lacks `mutating`) gives you confidence when reading code. This is especially valuable when structs are passed around — you know non-mutating methods are safe to call without accidentally changing your data.
