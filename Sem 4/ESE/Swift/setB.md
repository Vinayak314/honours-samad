# Set 2

## Question 1
Write a swift program to perform following:
- Create a User struct with username, password, and optional email.
- Write a login(user:) function that uses guard to validate non-empty username and password, and exits with an error if validation fails.
- If valid, print a welcome message and unwrap email using if let to display if available.
- Demonstrate the function with valid and invalid User instances.

### Code
```swift
struct User {
    var username: String
    var password: String
    var email: String?
}

enum LoginError: Error {
    case emptyCredentials
}

func login(user: User) throws {
    guard !user.username.isEmpty, !user.password.isEmpty else {
        print("Login Failed: Username or password cannot be empty.")
        throw LoginError.emptyCredentials
    }
    
    print("Welcome, \(user.username)!")
    
    if let email = user.email {
        print("Your email is: \(email)")
    } else {
        print("No email provided.")
    }
}

let validUser = User(username: "john_doe", password: "secure123", email: "john@example.com")
let invalidUser = User(username: "", password: "", email: nil)

do {
    try login(user: validUser)
    print("---")
    try login(user: invalidUser)
} catch {
    print("Error during login.")
}
```

## Question 2
Write a swift program to perform following for accessing User Info:
- Create a struct named UserProfile with a name (String) and an optional age (Int?).
- Write a function that takes a UserProfile instance.
- Use optional binding (if let) to safely unwrap the age property.
- If age has a value, print "User is [age] years old." Otherwise, print, "Age is not available."
- Demonstrate creating a UserProfile with and without an age and calling the function.

### Code
```swift
struct UserProfile {
    var name: String
    var age: Int?
}

func printUserInfo(profile: UserProfile) {
    if let age = profile.age {
        print("\(profile.name) is \(age) years old.")
    } else {
        print("Age is not available for \(profile.name).")
    }
}

let profileWithAge = UserProfile(name: "Alice", age: 25)
let profileWithoutAge = UserProfile(name: "Bob", age: nil)

printUserInfo(profile: profileWithAge)
printUserInfo(profile: profileWithoutAge)
```
