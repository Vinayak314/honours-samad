// Problem Statement 7: Optionals
// Safely unwrap an optional email string and age using optional binding.

var userEmail: String? = nil
var userAge: Int? = 25

// Unwrapping Email
if let email = userEmail {
    print("User email is: \(email)")
} else {
    print("Missing data: Email address not provided.")
}

// Unwrapping Age
if let age = userAge {
    print("User age is: \(age)")
} else {
    print("Missing data: Age not provided.")
}
