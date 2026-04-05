// Problem statement 5: Set Attendance Records
// Manage the attendance records of two workshops using sets.

var workshopA: Set<String> = ["Alice", "Bob", "Charlie", "David"]
var workshopB: Set<String> = ["Charlie", "David", "Eve", "Frank"]

// Attendees who attended both workshops
let attendedBoth = workshopA.intersection(workshopB)

// Attendees who attended only one workshop
let attendedOnlyOne = workshopA.symmetricDifference(workshopB)

// Combine all attendees into a single list without duplicates
let allAttendees = workshopA.union(workshopB)

print("Attended both workshops: \(attendedBoth)")
print("Attended only one workshop: \(attendedOnlyOne)")
print("All unique attendees: \(allAttendees)")
