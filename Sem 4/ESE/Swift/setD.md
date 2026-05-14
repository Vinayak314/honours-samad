# Set 4

## Question 1
Implement a task manager considering following conditions:
- Create a struct Task with a title (String) and isCompleted (Bool, default false).
- Write a function that takes an array of Task and a task title.
- The function should iterate through the array and set the isCompleted property to true for the task with the matching title.
- Demonstrate creating an array of Task and marking one as completed. Print the isCompleted status of that task before and after.

### Code
```swift
struct Task {
    var title: String
    var isCompleted: Bool = false
}

// Pass array as 'inout' so we can modify the original array in place
func markTaskCompleted(tasks: inout [Task], title: String) {
    for i in 0..<tasks.count {
        if tasks[i].title == title {
            tasks[i].isCompleted = true
        }
    }
}

var taskList = [
    Task(title: "Do homework"),
    Task(title: "Buy groceries")
]

print("Before: \(taskList[1].title) isCompleted = \(taskList[1].isCompleted)")

markTaskCompleted(tasks: &taskList, title: "Buy groceries")

print("After: \(taskList[1].title) isCompleted = \(taskList[1].isCompleted)")
```

## Question 2
Develop a student management system that stores roll numbers as keys and names as values in a dictionary.
- Write functions to add a new student, update a name, delete a student, and search by roll number.
- Show how to handle cases where a key might not exist.

### Code
```swift
var students: [Int: String] = [:]

func addStudent(rollNumber: Int, name: String) {
    if students[rollNumber] == nil {
        students[rollNumber] = name
        print("Added \(name) with Roll No: \(rollNumber)")
    } else {
        print("Roll No \(rollNumber) already exists.")
    }
}

func updateStudent(rollNumber: Int, newName: String) {
    if students.keys.contains(rollNumber) {
        students[rollNumber] = newName
        print("Updated Roll No \(rollNumber) to \(newName)")
    } else {
        print("Roll No \(rollNumber) not found to update.")
    }
}

func deleteStudent(rollNumber: Int) {
    if let removedName = students.removeValue(forKey: rollNumber) {
        print("Deleted student \(removedName) (Roll No: \(rollNumber))")
    } else {
        print("Roll No \(rollNumber) not found to delete.")
    }
}

func searchStudent(rollNumber: Int) {
    // Handling case where key might not exist using optional binding
    if let name = students[rollNumber] {
        print("Found: \(name) for Roll No \(rollNumber)")
    } else {
        print("Student with Roll No \(rollNumber) does not exist.")
    }
}

addStudent(rollNumber: 101, name: "Alice")
addStudent(rollNumber: 102, name: "Bob")
updateStudent(rollNumber: 101, newName: "Alicia")
searchStudent(rollNumber: 102)
searchStudent(rollNumber: 999) // Key doesn't exist
deleteStudent(rollNumber: 102)
```
