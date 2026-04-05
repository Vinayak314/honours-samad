// ============================================================
// Q1: Variables, Properties, Numbers, Strings, and Booleans
// ============================================================
// Create a struct `Student` with the following:
//   - Stored properties: name (String), marks (array of Int)
//   - A computed property `average` that returns the average marks as Double
//   - A computed property `grade` that returns a letter grade (String):
//       average >= 90 → "A", >= 80 → "B", >= 70 → "C", >= 60 → "D", else "F"
//   - A computed property `isPassing` (Bool) that returns true if grade is not "F"
//   - A method `summary()` that returns a formatted string with all info
// Then create two Student instances and print their summaries.
// ============================================================

struct Student {
    var name: String
    var marks: [Int]
    
    var average: Double {
        var sum = 0
        for m in marks { sum += m }
        return marks.isEmpty ? 0 : Double(sum) / Double(marks.count)
    }
    
    var grade: String {
        if average >= 90 { return "A" }
        if average >= 80 { return "B" }
        if average >= 70 { return "C" }
        if average >= 60 { return "D" }
        return "F"
    }
    
    var isPassing: Bool { return grade != "F" }
    
    func summary() -> String {
        return "\(name), Avg: \(average), Grade: \(grade), Pass: \(isPassing)"
    }
}

let s1 = Student(name: "Alice", marks: [88, 92, 76])
let s2 = Student(name: "Bob", marks: [45, 52])
print(s1.summary())
print(s2.summary())

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Structs (Value Types): We define a custom data structure `Student` to hold data and logic.
- Stored Properties: Variables like `name` and `marks` physically hold data within the struct.
- Computed Properties: Variables like `average` and `grade` don't store data directly. Instead, they calculate and return a value dynamically based on other properties whenever accessed.
*/
