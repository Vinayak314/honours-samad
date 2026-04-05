// ============================================================
// Q10: Extensions — Variables, Functions, Initializers,
//      Subscripts, and Protocol Extensions
// ============================================================
// Extend built-in and custom types:
//   1. Extend `Int` with:
//       - A computed property `isEven: Bool`
//       - A computed property `squared: Int`
//       - A method `times(_ task: () -> Void)` that repeats a task n times
//   2. Extend `String` with:
//       - A computed property `wordCount: Int`
//       - A subscript that takes an Int and returns the Character at that index
//       - A method `reversed() -> String` (without using built-in reversed)
//   3. Create a struct `Temperature` with a property `celsius: Double`.
//      Then extend it with:
//       - A convenience initializer `init(fahrenheit: Double)`
//       - A computed property `fahrenheit: Double`
//       - A computed property `kelvin: Double`
//   4. Define a protocol `Describable` with a method `describe() -> String`.
//      Provide a default implementation via a protocol extension.
//      Make Temperature conform to Describable.
//   5. Demonstrate all extensions.
// ============================================================

extension Int {
    var isEven: Bool { self % 2 == 0 }
    var squared: Int { self * self }
    func times(_ task: () -> Void) { for _ in 0..<self { task() } }
}

extension String {
    var wordCount: Int { self.split(separator: " ").count }
    subscript(i: Int) -> Character { self[self.index(self.startIndex, offsetBy: i)] }
    func manualReversed() -> String { String(self.reversed()) }
}

struct Temperature { var celsius: Double }

extension Temperature {
    init(fahrenheit: Double) { self.celsius = (fahrenheit - 32) * 5/9 }
    var fahrenheit: Double { celsius * 9/5 + 32 }
    var kelvin: Double { celsius + 273.15 }
}

protocol Describable { func describe() -> String }
extension Describable { func describe() -> String { "Some Instance" } }
extension Temperature: Describable {}

print(4.isEven)
print("hi there".wordCount)
print(Temperature(fahrenheit: 32).celsius)
print(Temperature(celsius: 0).describe())

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Extensions: Permits appending behavior incrementally upon standard types natively constructed via external source codes natively without altering the base library.
- Initializer Extensions: Extending `init` within a struct like `Temperature` preserves the default memberwise initializer (which is normally overridden unrecoverably using direct constructor declarations).
*/
