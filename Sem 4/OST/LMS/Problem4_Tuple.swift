// Problem Statement 4: Tuple Product Comparison
// Compare three products using tuples. Print the most expensive, highest-rated, 
// and products below a given threshold.

let prod1 = (name: "Wireless Earbuds", price: 1500.0, rating: 4.8)
let prod2 = (name: "Power Bank", price: 450.0, rating: 4.2)
let prod3 = (name: "Charging Cable", price: 299.0, rating: 4.5)

// Identify the Most Expensive Product
var mostExpensive = prod1
if prod2.price > mostExpensive.price { mostExpensive = prod2 }
if prod3.price > mostExpensive.price { mostExpensive = prod3 }

// Identify the Highest-Rated Product
var highestRated = prod1
if prod2.rating > highestRated.rating { highestRated = prod2 }
if prod3.rating > highestRated.rating { highestRated = prod3 }

print("Most Expensive Product: \(mostExpensive.name) (₹\(mostExpensive.price), Rating: \(mostExpensive.rating))")
print("Highest-Rated Product: \(highestRated.name) (₹\(highestRated.price), Rating: \(highestRated.rating))")

print("\nProducts under ₹500 threshold:")
let threshold = 500.0
var foundAny = false

if prod1.price < threshold {
    print("- \(prod1.name) (₹\(prod1.price))")
    foundAny = true
}
if prod2.price < threshold {
    print("- \(prod2.name) (₹\(prod2.price))")
    foundAny = true
}
if prod3.price < threshold {
    print("- \(prod3.name) (₹\(prod3.price))")
    foundAny = true
}

if !foundAny {
    print("No products found under the given price threshold.")
}
