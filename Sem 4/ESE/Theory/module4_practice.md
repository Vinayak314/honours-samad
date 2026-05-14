# Module 4 — Navigation, Lifecycle, JSON, Error Handling & Generics (Practice Questions)

> Covers Scope, Segues & Navigation Controllers, Tab Bar Controllers, View Controller Life Cycle, JSON serialization (`Codable`), Error Handling, and Generics.

---

## 4-01: Scope

---

### Q1. What is Variable Scope in Swift? Explain local scope, global scope, and variable shadowing.

#### Answer

**Scope** determines the region of code where a variable or constant is visible and accessible.

| Scope | Where defined | Accessible from |
|---|---|---|
| **Global** | Outside any function, class, or struct | Anywhere in the file/module |
| **Local** | Inside a function, loop, or block `{ }` | Only within that block |

**Variable Shadowing** occurs when a variable in a local scope has the same name as one in an outer scope. The inner variable "shadows" (overrides) the outer one within that block.

```swift
var myName = "Global Name" // Global scope

func printName() {
    var myName = "Local Name" // This 'shadows' the global variable
    print(myName) // Outputs: "Local Name"
}

printName()
print(myName) // Outputs: "Global Name"
```

### Key Rules

1. **Inner scopes can access outer scope** variables.
2. **Outer scopes cannot access inner scope** variables.
3. A variable is **destroyed** when its scope ends.
4. If two variables have the **same name** in nested scopes, the innermost one takes priority (shadowing).

---

## 4-02: Navigation and Segues

---

### Q2. What is a Navigation Controller in iOS, and how does it manage the view controller hierarchy?

#### Answer

A **Navigation Controller** (`UINavigationController`) is a container view controller that manages navigation through a hierarchy of content using a **stack** data structure (Last-In, First-Out).

*   **Push:** When navigating deeper into the app (e.g., tapping an item in a list to see its details), a new view controller is "pushed" onto the navigation stack.
*   **Pop:** When the user taps the "Back" button, the top view controller is "popped" off the stack, revealing the previous one.

The Navigation Controller automatically provides a **navigation bar** at the top of the screen, which houses the back button, title, and optional bar button items.

---

### Q3. What is a Segue? Explain how to pass data between View Controllers using `prepare(for:sender:)`.

#### Answer

A **Segue** defines a transition between two view controllers in a Storyboard. It handles the visual animation and instantiates the destination view controller.

To pass data from a source to a destination view controller, you override `prepare(for:sender:)` in the source:

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // 1. Check the segue identifier to make sure it's the right one
    if segue.identifier == "showDetail" {
        
        // 2. Downcast the destination to the correct type
        if let destinationVC = segue.destination as? DetailViewController {
            
            // 3. Pass the data by setting a property on the destination
            destinationVC.selectedItemName = "Apple"
        }
    }
}
```

**Types of Segues:**
- **Show (Push):** Pushes the destination onto a navigation stack.
- **Present Modally:** Presents the destination as a modal sheet.
- **Present As Popover:** Presents the destination as a popover (iPad).

---

### Q4. What is an Unwind Segue and what is it used for?

#### Answer

An **Unwind Segue** is used to navigate **backwards** through one or more segues. Unlike the back button (which only pops one screen), an unwind segue can jump back multiple screens at once. It can also be used to **pass data backwards** to the previous screen.

**Steps to create an Unwind Segue:**

1. In the **destination** view controller (the one you want to return to), write an `@IBAction` method with a `UIStoryboardSegue` parameter:

```swift
@IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    let sourceVC = unwindSegue.source
    // Retrieve data from the source if needed
}
```

2. In the Storyboard, Ctrl-drag from a button on the **source** screen to the "Exit" icon at the top of the scene. Select the unwind action method.

---

## 4-03: Tab Bar Controllers

---

### Q5. How does a Tab Bar Controller differ from a Navigation Controller?

#### Answer

| Feature | Tab Bar Controller | Navigation Controller |
|---|---|---|
| Data structure | **Array** of independent VCs | **Stack** of dependent VCs |
| UI element | Tabs at the **bottom** of screen | Navigation bar at the **top** |
| Navigation style | **Flat** — switch between sections | **Hierarchical** — drill down into data |
| View controllers | Exist in **parallel** | Exist in a **stack** (push/pop) |

**Common pattern:** Embed a Navigation Controller *inside* each tab of a Tab Bar Controller, so each tab can have its own navigation hierarchy.

---

## 4-04: View Controller Life Cycle

---

### Q6. Describe the View Controller Lifecycle in iOS. What are the key methods and when are they called?

#### Answer

The View Controller Lifecycle is a series of methods called by the system as a view controller's views appear and disappear.

| Method | When Called | Common Use |
|---|---|---|
| `viewDidLoad()` | **Once** — when the view is loaded into memory | One-time setup, outlet configuration |
| `viewWillAppear(_:)` | **Each time** before the view becomes visible | Refresh data, show/hide navigation bars |
| `viewDidAppear(_:)` | **Each time** after the view is fully visible | Start animations, request permissions |
| `viewWillDisappear(_:)` | **Each time** before the view is removed | Save edits, hide keyboard |
| `viewDidDisappear(_:)` | **Each time** after the view has disappeared | Stop background tasks, tear down observers |

**Key distinction:** `viewDidLoad()` runs once per instance. The `appear/disappear` methods run every time the user navigates to/from that screen.

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View loaded into memory — one-time setup here")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View is about to appear — refresh data here")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View appeared — start animations here")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View will disappear — save state here")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View disappeared — stop tasks here")
    }
}
```

---

## 4-05: Error Handling

---

### Q7. Explain how error handling works in Swift using `throws`, `do`, `try`, and `catch`.

#### Answer

Swift uses a structured approach to error handling:

1. **Define errors** using an `enum` conforming to the `Error` protocol.
2. **Throw errors** from functions marked with `throws`.
3. **Handle errors** using `do-catch` blocks with `try`.

```swift
// 1. Define
enum FileError: Error {
    case fileNotFound
    case unreadable
}

// 2. Throw
func readFile(named name: String) throws -> String {
    if name.isEmpty { throw FileError.fileNotFound }
    return "File contents here."
}

// 3. Handle
do {
    let content = try readFile(named: "Document")
    print(content)
} catch FileError.fileNotFound {
    print("Could not find the file.")
} catch {
    print("An unknown error occurred: \(error)")
}
```

---

### Q8. What is the difference between `try`, `try?`, and `try!` in Swift?

#### Answer

| Keyword | Behavior | Returns |
|---|---|---|
| `try` | Must be inside `do-catch`. Error is caught and handled explicitly. | The actual value |
| `try?` | Converts the result to an optional. Returns `nil` if the function throws. | `Optional` value |
| `try!` | Force unwraps the result. **Crashes** if the function throws. | Non-optional value |

```swift
// try — full error handling
do {
    let result = try readFile(named: "test")
} catch {
    print(error)
}

// try? — returns nil on failure
let result = try? readFile(named: "test") // Optional<String>

// try! — crashes if error is thrown
let result = try! readFile(named: "test") // Use ONLY when you're 100% sure it won't fail
```

---

## 4-06: Read and Write JSON

---

### Q9. How do you read and write JSON data to a local file in Swift using the `Codable` protocol?

#### Answer

The `Codable` protocol (a type alias for `Encodable & Decodable`) allows Swift to automatically map JSON properties to Swift struct properties.

- **`JSONEncoder`** converts Swift objects → JSON `Data`
- **`JSONDecoder`** converts JSON `Data` → Swift objects

```swift
import Foundation

struct User: Codable {
    var name: String
    var age: Int
}

let user = User(name: "John", age: 30)

// Get document directory URL
let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = docs.appendingPathComponent("user.json")

do {
    // WRITING — Encode the struct to JSON Data and save to file
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(user)
    try jsonData.write(to: fileURL)
    
    // READING — Load the Data from file and decode back to struct
    let savedData = try Data(contentsOf: fileURL)
    let decoder = JSONDecoder()
    let decodedUser = try decoder.decode(User.self, from: savedData)
    
    print(decodedUser.name) // Outputs: John
} catch {
    print("JSON Error: \(error)")
}
```

---

### Q10. What is the `CodingKeys` enum and when do you need it?

#### Answer

`CodingKeys` is an enum you define inside your `Codable` struct when the **JSON key names don't match** your Swift property names. It maps each Swift property to its corresponding JSON key.

```swift
struct User: Codable {
    var firstName: String
    var userAge: Int
    
    // Maps Swift property names to JSON keys
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case userAge = "age"
    }
}

// This struct can now decode JSON like: {"first_name": "Alice", "age": 25}
```

Without `CodingKeys`, Swift expects the JSON keys to exactly match the property names.

---

## 4-07: Generics

---

### Q11. What are Generics in Swift? Provide an example of a generic function and a generic struct.

#### Answer

**Generics** allow you to write flexible, reusable functions and types that can work with *any* data type, while still maintaining compile-time type safety. The placeholder type (like `<T>`) is replaced by the actual type when the code is used.

**Generic Function:**

```swift
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 5, y = 10
swapValues(&x, &y) // Swift infers T is Int
```

**Generic Struct:**

```swift
struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        return items.isEmpty ? nil : items.removeLast()
    }
}

var intStack = Stack<Int>()
intStack.push(3)
intStack.push(7)
print(intStack.pop()!) // 7
```

---

### Q12. What are Type Constraints in Generics? Give an example.

#### Answer

**Type Constraints** restrict a generic type parameter so it must conform to a specific protocol or inherit from a specific class. This guarantees the generic type has certain capabilities.

```swift
// T must conform to Comparable — so we can use the '>' operator
func findMax<T: Comparable>(in array: [T]) -> T? {
    guard var max = array.first else { return nil }
    for element in array {
        if element > max {
            max = element
        }
    }
    return max
}

print(findMax(in: [3, 1, 7, 2])!)     // 7
print(findMax(in: ["b", "z", "a"])!)   // z
```

Without the `Comparable` constraint, the compiler would not allow the `>` comparison because it wouldn't know if `T` supports it.
