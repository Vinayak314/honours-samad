// ============================================================
// QUESTION:
// Problem 3.2: E-Commerce Order System with Payment Modes
// Simulate an order system where users pay using different payment methods.
// 
// - Define enum PaymentMode:
//   .creditCard(number: String), .upi(id: String), .cashOnDelivery, .wallet(balance: Double)
// - Create a struct Order with orderId, amount, paymentMode: PaymentMode
//   - Use a failable initializer with guard to check valid amount > 0 and non-empty orderId
// - In OrderManager class:
//   - Store orders in a dictionary
//   - Use subscript to fetch an order by ID
//   - Use a closure to return all orders paid by wallet with balance > 100
// ============================================================

enum PaymentMode {
    case creditCard(number: String)
    case upi(id: String)
    case cashOnDelivery
    case wallet(balance: Double)
}

struct Order {
    let orderId: String
    let amount: Double
    let paymentMode: PaymentMode
    
    // Failable initializer
    init?(orderId: String, amount: Double, paymentMode: PaymentMode) {
        // Validation using guard
        guard !orderId.isEmpty, amount > 0 else {
            return nil
        }
        self.orderId = orderId
        self.amount = amount
        self.paymentMode = paymentMode
    }
}

class OrderManager {
    // Dictionary to store orders
    private var orders: [String: Order] = [:]
    
    // Subscript to fetch or update an order by ID
    subscript(orderId: String) -> Order? {
        get {
            return orders[orderId]
        }
        set {
            orders[orderId] = newValue
        }
    }
    
    // Function returning orders paid by wallet with balance > 100 using a closure
    func getHighBalanceWalletOrders() -> [Order] {
        return orders.values.filter { order in
            // Pattern match to extract wallet balance
            if case .wallet(let balance) = order.paymentMode {
                return balance > 100
            }
            return false
        }
    }
}

// ============================================================
// EXAMPLE USAGE:
// ============================================================
let manager = OrderManager()

// Adding new valid orders
if let o1 = Order(orderId: "ORD1", amount: 50.0, paymentMode: .creditCard(number: "1234-5678-9012-3456")) { 
    manager[o1.orderId] = o1 
}
if let o2 = Order(orderId: "ORD2", amount: 200.0, paymentMode: .wallet(balance: 150.0)) { 
    manager[o2.orderId] = o2 
}
if let o3 = Order(orderId: "ORD3", amount: 15.0, paymentMode: .wallet(balance: 50.0)) { 
    manager[o3.orderId] = o3 
}
if let o4 = Order(orderId: "ORD4", amount: 120.0, paymentMode: .cashOnDelivery) { 
    manager[o4.orderId] = o4 
}

// Attempting to add an invalid order (amount <= 0)
let invalidOrder = Order(orderId: "ORD5", amount: -5.0, paymentMode: .upi(id: "user@upi"))
print("Was invalid order created? \(invalidOrder != nil)") // Output: false

let highBalWalletOrders = manager.getHighBalanceWalletOrders()
print("\n--- Wallet Orders with Balance > 100 ---")
for order in highBalWalletOrders {
    print("Order ID: \(order.orderId), Amount: $\(order.amount), Mode: \(order.paymentMode)")
}

/*
============================================================
EXPLANATION:
1. Enums with Associated Values: `PaymentMode` utilizes associated values like `(balance: Double)` to store specific parameters directly onto cases, avoiding boilerplate code while representing exact states.
2. Struct Failable Init: Struct `Order` safely aborts instantiation and returns `nil` when `guard` detects invalid conditions (`!orderId.isEmpty` & `amount > 0`).
3. Dictionary Subscripting: A custom subscript securely maps the `OrderManager` instance to behave like its internal dictionary, making order lookups natively accessible via String IDs (`manager["ORD1"]`).
4. Closures & Pattern Matching: Inside the `.filter()` closure, `if case .wallet(let bal) = order.paymentMode` concisely extracts associated data specific to the `.wallet` enum strictly for conditions comparing balance `> 100`.
============================================================
*/
