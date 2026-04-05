// ============================================================
// Q5: Protocols, Protocol Extensions, Associated Types, Hashable
// ============================================================
// Implement a notification system using protocols:
//   1. Define a protocol `Notifiable` with an associated type `MessageType`.
//      It should require:
//       - var id: String { get }
//       - func send(message: MessageType)
//       - func receiveAll() -> [MessageType]
//   2. Define a protocol `Prioritizable` with:
//       - var priority: Int { get }
//   3. Make `Prioritizable` conform to Comparable via a protocol extension
//      (compare by priority).
//   4. Create a struct `Notification` that conforms to Hashable and Prioritizable.
//      Properties: id (String), content (String), priority (Int)
//   5. Create a class `EmailNotifier` conforming to `Notifiable` where
//      MessageType == Notification.
//   6. Create a class `SMSNotifier` conforming to `Notifiable` where
//      MessageType == String.
//   7. Demonstrate: send notifications, retrieve them, sort by priority,
//      and use Set<Notification> to demonstrate Hashable.
// ============================================================

protocol Notifiable {
    associatedtype MessageType
    var id: String { get }
    func send(message: MessageType)
    func receiveAll() -> [MessageType]
}

protocol Prioritizable { var priority: Int { get } }

extension Prioritizable where Self: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool { lhs.priority < rhs.priority }
}

struct Notification: Hashable, Prioritizable, Comparable {
    var id: String
    var content: String
    var priority: Int
}

class EmailNotifier: Notifiable {
    var id = "email"
    var inbox: [Notification] = []
    func send(message: Notification) { inbox.append(message) }
    func receiveAll() -> [Notification] { inbox }
}

class SMSNotifier: Notifiable {
    var id = "sms"
    var msgs: [String] = []
    func send(message: String) { msgs.append(message) }
    func receiveAll() -> [String] { msgs }
}

let email = EmailNotifier()
email.send(message: Notification(id: "1", content: "Hi", priority: 1))
email.send(message: Notification(id: "2", content: "Alert", priority: 5))

print(email.receiveAll().sorted())

var set: Set<Notification> = [Notification(id: "1", content: "Hi", priority: 1)]
print(set)

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Protocols: Define explicit blueprints of methods and properties. `Notifiable` acts as an enforceable interface contract.
- Associated Types: Allows protocols to serve generically. `MessageType` acts as a placeholder specified later by the confirming class (e.g. `Notification` or `String`).
- Protocol Extensions: Provide a free default implementation (for instance, the `<` operation for `Prioritizable`), removing redundant boilerplate on conforming objects.
*/
