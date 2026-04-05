// Problem Statement 1: Shopping Cart
// Write a Swift program to calculate the total price of items in a shopping cart, 
// including tax, discounts, and surcharges, using constant variables and operators.

let item1Price: Double = 120.0
let item2Price: Double = 50.0
let item3Price: Double = 30.0
let item4Price: Double = 200.0
let item5Price: Double = 100.0

let taxRate: Double = 0.08      // 8% tax
let discountRate: Double = 0.10 // 10% discount
let surcharge: Double = 15.0    // Flat surcharge

let subtotal = item1Price + item2Price + item3Price + item4Price + item5Price
let discountAmount = subtotal * discountRate
let taxAmount = subtotal * taxRate
let totalAmount = (subtotal - discountAmount) + taxAmount + surcharge

print("--- Shopping Cart Details ---")
print("Subtotal: $\(subtotal)")
print("Discount: $\(discountAmount)")
print("Tax:      $\(taxAmount)")
print("Surcharge:$\(surcharge)")
print("---------------------------")
print("Total Amount: $\(totalAmount)")
