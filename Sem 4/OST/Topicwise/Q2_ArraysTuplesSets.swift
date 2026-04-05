// ============================================================
// Q2: Arrays, Tuples, Sets, and Dictionaries
// ============================================================
// Implement an inventory management system:
//   1. Create a dictionary `inventory` of type [String: (price: Double, qty: Int)]
//      mapping product names to a tuple of price and quantity.
//   2. Write a function `addProduct` that adds/updates a product in the inventory.
//   3. Write a function `totalValue` that returns the total monetary value of 
//      all products (price * qty summed up).
//   4. Write a function `outOfStock` that returns a Set<String> of product names
//      with qty == 0.
//   5. Write a function `commonProducts` that takes two inventories and returns
//      a Set of product names present in both.
//   6. Demonstrate all functions with sample data.
// ============================================================

var inventory: [String: (price: Double, qty: Int)] = [:]

func addProduct(_ name: String, price: Double, qty: Int, to inv: inout [String: (price: Double, qty: Int)]) {
    inv[name] = (price, qty)
}

func totalValue(of inv: [String: (price: Double, qty: Int)]) -> Double {
    var total: Double = 0
    for item in inv.values { total += item.price * Double(item.qty) }
    return total
}

func outOfStock(in inv: [String: (price: Double, qty: Int)]) -> Set<String> {
    var out: Set<String> = []
    for (name, item) in inv { if item.qty == 0 { out.insert(name) } }
    return out
}

func commonProducts(_ inv1: [String: (price: Double, qty: Int)], _ inv2: [String: (price: Double, qty: Int)]) -> Set<String> {
    return Set(inv1.keys).intersection(Set(inv2.keys))
}

addProduct("Laptop", price: 1000, qty: 5, to: &inventory)
addProduct("Mouse", price: 20, qty: 0, to: &inventory)

print("Total value:", totalValue(of: inventory))
print("Out of stock:", outOfStock(in: inventory))

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Dictionaries: `inventory` stores key-value pairs mapping product names strictly to tuple details.
- Tuples: Group multiple values (price, qty) into a single compound value without needing a struct.
- Sets: Unordered collections of unique elements. Used here to easily perform powerful grouping features like `.intersection`.
- inout Parameters: Prefixing `&` allows a function to persistently modify a variable passed by reference.
*/
