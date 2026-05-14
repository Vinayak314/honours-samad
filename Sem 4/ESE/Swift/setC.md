# Set 3

## Question 1
An event app tracks attendees and performs operations like checking for duplicates or preferences. Requirements:
- Create a protocol `AttendeeInfo` with a method `getDetails()`.
- Define a class `Attendee` conforming to this protocol with properties like `name`, `id`, and `eventPreference`.
- Use a `Set` to store unique attendee IDs.
- Write a function that accepts a closure to filter attendees based on their event preference.

### Code
```swift
protocol AttendeeInfo {
    func getDetails() -> String
}

class Attendee: AttendeeInfo {
    var name: String
    var id: Int
    var eventPreference: String
    
    init(name: String, id: Int, eventPreference: String) {
        self.name = name
        self.id = id
        self.eventPreference = eventPreference
    }
    
    func getDetails() -> String {
        return "[\(id)] \(name) prefers \(eventPreference)"
    }
}

var uniqueAttendeeIDs = Set<Int>()
var attendees: [Attendee] = []

func addAttendee(_ attendee: Attendee) {
    if uniqueAttendeeIDs.insert(attendee.id).inserted {
        attendees.append(attendee)
    } else {
        print("Duplicate ID \(attendee.id) for \(attendee.name). Ignored.")
    }
}

addAttendee(Attendee(name: "Alice", id: 101, eventPreference: "Workshop"))
addAttendee(Attendee(name: "Bob", id: 102, eventPreference: "Keynote"))
addAttendee(Attendee(name: "Charlie", id: 101, eventPreference: "Workshop")) // Duplicate

func filterAttendees(using filterClosure: (Attendee) -> Bool) -> [Attendee] {
    return attendees.filter(filterClosure)
}

let workshopLovers = filterAttendees { $0.eventPreference == "Workshop" }
print("Workshop attendees:")
for attendee in workshopLovers {
    print(attendee.getDetails())
}
```

## Question 2
Write a swift program for the following scenario:
- Create an enum `OrderStatus` with cases: `Placed`, `Dispatched`, `InTransit`, and `Delivered`, each returning a message.
- Define a struct `Order` with `id`, `status`, and optional `customerName`.
- Write a `trackOrder(order:)` function using guard to validate the optional order and customer name.
- Print a greeting and the order status message; demonstrate with valid, missing name, and nil cases.

### Code
```swift
enum OrderStatus {
    case Placed, Dispatched, InTransit, Delivered
    
    var message: String {
        switch self {
        case .Placed: return "Your order has been placed."
        case .Dispatched: return "Your order has been dispatched."
        case .InTransit: return "Your order is in transit."
        case .Delivered: return "Your order has been delivered."
        }
    }
}

struct Order {
    var id: Int
    var status: OrderStatus
    var customerName: String?
}

func trackOrder(order: Order?) {
    guard let validOrder = order else {
        print("Order not found (nil).")
        return
    }
    
    guard let name = validOrder.customerName else {
        print("Hello Valued Customer, \(validOrder.status.message)")
        return
    }
    
    print("Hello \(name), \(validOrder.status.message)")
}

let validOrder = Order(id: 1, status: .InTransit, customerName: "Sarah")
let missingNameOrder = Order(id: 2, status: .Placed, customerName: nil)
let nilOrder: Order? = nil

trackOrder(order: validOrder)
trackOrder(order: missingNameOrder)
trackOrder(order: nilOrder)
```
