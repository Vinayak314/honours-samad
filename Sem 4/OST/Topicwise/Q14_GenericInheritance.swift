// ============================================================
// Q14: Generic Class Inheritance and Advanced Type Constraints
// ============================================================
// Build a generic repository pattern with inheritance:
//   1. Create a protocol `Identifiable` with var id: String { get }
//   2. Create a generic base class `Repository<T: Identifiable>` with:
//       - A private array of T items
//       - Methods: add, findById, removeById, getAll, count
//   3. Create a subclass `SortableRepository<T>` where T is both
//      Identifiable and Comparable. Add a method `allSorted() -> [T]`.
//   4. Create a struct `Product: Identifiable, Comparable` with
//      id, name, price. Compare by price.
//   5. Demonstrate adding, finding, removing, and sorting products.
// ============================================================

protocol Identifiable { var id: String { get } }

class Repository<T: Identifiable> {
    private var items = [T]()
    func add(_ item: T) { items.append(item) }
    func findById(_ id: String) -> T? { items.first { $0.id == id } }
    func removeById(_ id: String) { items.removeAll { $0.id == id } }
    func getAll() -> [T] { items }
    var count: Int { items.count }
}

class SortableRepository<T: Identifiable & Comparable>: Repository<T> {
    func allSorted() -> [T] { getAll().sorted() }
}

struct Product: Identifiable, Comparable {
    var id, name: String; var price: Double
    static func < (lhs: Product, rhs: Product) -> Bool { lhs.price < rhs.price }
}

let repo = SortableRepository<Product>()
repo.add(Product(id: "1", name: "A", price: 10))
repo.add(Product(id: "2", name: "B", price: 5))

print(repo.allSorted().map { $0.price })
repo.removeById("1")
print(repo.count)

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Generic Inheritance: Permitting complex parent architectures holding structural generic elements mapping down strictly to descendants mapping properties dynamically.
- Complex Typing Boundaries: `T: Identifiable & Comparable` anchors compilation logic explicitly requiring dual structural protocol compliances ensuring specific structural requirements.
*/
