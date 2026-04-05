// Problem statement 2: Restaurant Bill Invoice
// Write a Swift program to simulate a simple invoice system for a restaurant bill 
// that includes GST, a service charge, and a tip. Avoid using loops, classes, or functions.

let item1Price: Double = 250.0
let item2Price: Double = 180.0
let item3Price: Double = 400.0
let item4Price: Double = 120.0

let gstRate: Double = 0.18            // 18% GST
let serviceChargeRate: Double = 0.05  // 5% Service Charge
let tip: Double = 100.0               // Fixed Tip

let subtotal = item1Price + item2Price + item3Price + item4Price
let gstAmount = subtotal * gstRate
let serviceChargeAmount = subtotal * serviceChargeRate
let grandTotal = subtotal + gstAmount + serviceChargeAmount + tip

print("====== INVOICE ======")
print("Item 1: ₹\(item1Price)")
print("Item 2: ₹\(item2Price)")
print("Item 3: ₹\(item3Price)")
print("Item 4: ₹\(item4Price)")
print("---------------------")
print("Subtotal:       ₹\(subtotal)")
print("GST (18%):      ₹\(gstAmount)")
print("Service Charge: ₹\(serviceChargeAmount)")
print("Tip:            ₹\(tip)")
print("---------------------")
print("GRAND TOTAL:    ₹\(grandTotal)")
print("=====================")
