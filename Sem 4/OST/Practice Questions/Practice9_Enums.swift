// Problem Statement 9: Enums
// Represent the delivery status of a package using an Enum.

enum DeliveryStatus {
    case processing
    case shipped
    case outForDelivery
    case delivered
}

let trackingState: DeliveryStatus = .outForDelivery

switch trackingState {
case .processing:
    print("Your order is being processed by the warehouse.")
case .shipped:
    print("Your package has shipped and is on its way!")
case .outForDelivery:
    print("Keep an eye out! Your package is out for delivery today.")
case .delivered:
    print("Your package was delivered successfully.")
}
