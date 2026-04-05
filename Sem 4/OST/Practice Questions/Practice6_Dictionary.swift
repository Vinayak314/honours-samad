// Problem Statement 6: Dictionary
// Write a Swift program to simulate a simple student grades book using dictionaries.

var gradeBook: [String: Int] = [
    "Alice": 85,
    "Bob": 72,
    "Charlie": 90
]

// Add a new student
gradeBook["Dave"] = 88

// Update an existing student's score
if gradeBook["Alice"] != nil {
    gradeBook["Alice"] = 92
}

// Remove a student
gradeBook.removeValue(forKey: "Bob")

// Print final dictionary
print("Final Grade Book Roster:")
print(gradeBook)
