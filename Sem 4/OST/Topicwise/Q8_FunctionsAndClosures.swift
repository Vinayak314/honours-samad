// ============================================================
// Q8: Functions, Variadic Parameters, Inout, Function Types,
//     Passing/Returning Functions, Trailing Closure Syntax
// ============================================================
// Build a math toolkit:
//   1. Write a function `average(_ numbers: Double...)` using variadic parameters
//      that returns the average.
//   2. Write a function `swapValues(_ a: inout Int, _ b: inout Int)` using inout.
//   3. Write a function `makeMultiplier(factor: Int) -> (Int) -> Int` that returns
//      a closure which multiplies its argument by `factor`.
//   4. Write a function `applyOperation(_ a: Int, _ b: Int, 
//      operation: (Int, Int) -> Int) -> Int` that takes a function type as parameter.
//   5. Write a function `repeatTask(times: Int, task: () -> Void)` and call it
//      using trailing closure syntax.
//   6. Write a function `transform(_ array: [Int], using: (Int) -> Int) -> [Int]`
//      that applies a closure to each element. Demonstrate with trailing closure.
//   7. Demonstrate all functions.
// ============================================================

func average(_ numbers: Double...) -> Double {
    return numbers.reduce(0, +) / Double(numbers.count)
}

func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a; a = b; b = temp
}

func makeMultiplier(factor: Int) -> (Int) -> Int {
    return { $0 * factor }
}

func applyOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

func repeatTask(times: Int, task: () -> Void) {
    for _ in 0..<times { task() }
}

func transform(_ array: [Int], using transformer: (Int) -> Int) -> [Int] {
    return array.map(transformer)
}

print(average(1, 2, 3))

var x=1, y=2; swapValues(&x, &y)

let tripler = makeMultiplier(factor: 3)
print(tripler(5))

print(applyOperation(10, 5, operation: +))

repeatTask(times: 2) { print("Hi") }

print(transform([1,2,3]) { $0 * 2 })

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Variadic Parameters (`...`): Explicitly absorbs zero or more parameterized values inherently into an Array.
- Function Types: Swift functions are 'first-class citizens', meaning you natively pass executable blocks of functions as variables natively like `operation: (Int, Int) -> Int`.
- Trailing Closures: If the last parameter accepted represents a closure, syntax neatly structures curly braces outside the standard method parentheses.
*/
