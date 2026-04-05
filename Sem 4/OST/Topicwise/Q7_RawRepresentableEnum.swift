// ============================================================
// Q7: RawRepresentable (Extensible Enum) Protocol
// ============================================================
// Implement an extensible configuration system using RawRepresentable:
//   1. Create a struct `HTTPMethod` that conforms to RawRepresentable, 
//      Hashable, and CustomStringConvertible.
//       - rawValue is String
//       - Provide static constants: .get, .post, .put, .delete, .patch
//   2. Create a struct `APIRequest` with properties:
//       - url: String
//       - method: HTTPMethod
//       - headers: [String: String]
//   3. Add a method `describe()` that prints a formatted request description.
//   4. Demonstrate creating requests with both predefined and custom HTTP methods,
//      and show that HTTPMethod can be used in a switch statement 
//      and as a dictionary key (Hashable).
// ============================================================

struct HTTPMethod: RawRepresentable, Hashable, CustomStringConvertible {
    var rawValue: String
    static let get = HTTPMethod(rawValue: "GET")
    static let post = HTTPMethod(rawValue: "POST")
    static let put = HTTPMethod(rawValue: "PUT")
    static let delete = HTTPMethod(rawValue: "DELETE")
    static let patch = HTTPMethod(rawValue: "PATCH")
    var description: String { rawValue }
}

struct APIRequest {
    var url: String
    var method: HTTPMethod
    var headers: [String: String]
    func describe() { print("\(method) \(url) Headers: \(headers)") }
}

let req1 = APIRequest(url: "example.com", method: .get, headers: [:])
let customReq = APIRequest(url: "example.com", method: HTTPMethod(rawValue: "OPTIONS"), headers: [:])

req1.describe()
customReq.describe()

var dict: [HTTPMethod: Int] = [.get: 10, .post: 5]
print("Dict Hashable usage:", dict)

switch req1.method {
case .get: print("Matched GET")
default: print("Matched Other")
}

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Extensible Enums (`RawRepresentable`): Rather than using rigid enumerations missing native case expansions, using a struct conforming to `RawRepresentable` mimics enum static constants while enabling customized instancing cases dynamically.
- Hashable: Ensures the system understands how to quickly sequence the custom struct for uniqueness in Dictionaries and Sets.
*/
