// ============================================================
// Q13: Generics — Generic Functions, Type Constraints,
//      Generic Classes, Simplifying Array Functions
// ============================================================
// Build a generic data structures toolkit:
//   1. Write a generic function `swapTwo<T>(_ a: inout T, _ b: inout T)`
//      that swaps any two values.
//   2. Write a generic function `findIndex<T: Equatable>(of value: T, 
//      in array: [T]) -> Int?` with a type constraint requiring Equatable.
//   3. Write a generic function `filterArray<T>(_ array: [T], 
//      condition: (T) -> Bool) -> [T]` that filters elements by a condition.
//   4. Create a generic class `Stack<Element>` with:
//       - push, pop, peek, isEmpty, count
//       - A method `toArray() -> [Element]`
//   5. Extend Stack where Element: Equatable to add a `contains` method.
//   6. Extend Stack where Element: Comparable to add a `sorted` method.
//   7. Demonstrate all generic functions and the Stack with different types.
// ============================================================

func swapTwo<T>(_ a: inout T, _ b: inout T) { let temp=a; a=b; b=temp }
func findIndex<T: Equatable>(of value: T, in array: [T]) -> Int? { array.firstIndex(of: value) }
func filterArray<T>(_ array: [T], condition: (T) -> Bool) -> [T] { array.filter(condition) }

class Stack<T> {
    var items = [T]()
    var isEmpty: Bool { items.isEmpty }
    var count: Int { items.count }
    func push(_ item: T) { items.append(item) }
    func pop() -> T? { items.popLast() }
    func peek() -> T? { items.last }
    func toArray() -> [T] { items }
}

extension Stack where T: Equatable { func contains(_ item: T) -> Bool { items.contains(item) } }
extension Stack where T: Comparable { func sorted() -> [T] { items.sorted() } }

var x=1, y=2; swapTwo(&x, &y)
print(findIndex(of: 2, in: [1,2,3]))
print(filterArray([1, 2, 3]) { $0 > 1 })

let s = Stack<Int>()
s.push(3); s.push(1)
print(s.sorted())
print(s.contains(1))

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Generics (`<T>`): Facilitates fully type-safe abstraction scaling identically operating upon generalized placeholders preserving structural flexibility strictly defining boundaries natively avoiding loose runtime interpretations.
- Conditional Type Constraints: Extending implementations via `where T: Comparable` dynamically bridges structural capabilities dependent entirely whether the generalized component fulfills structural comparison guidelines logic natively.
*/
