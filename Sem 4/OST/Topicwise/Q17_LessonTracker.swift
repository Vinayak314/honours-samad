import Foundation

// ============================================================
// QUESTION:
// Online Learning Platform – Lesson Tracker
// Track student progress across lessons in an online platform.
// - Define an enum LessonStatus with cases: .notStarted, .inProgress, .completed, .failed(reason: String)
// - Create a Lesson class with lessonId, title, and status
//   - Initializer must use guard to ensure title is not empty and lessonId has at least 5 characters
// - Create a ProgressTracker class:
//   - Stores lessons in a dictionary
//   - Uses a subscript to update status of a lesson
//   - Has a function using a closure to get all failed lessons with a reason containing a keyword
// ============================================================

enum LessonStatus {
    case notStarted
    case inProgress
    case completed
    case failed(reason: String)
}

class Lesson {
    let lessonId: String
    var title: String
    var status: LessonStatus
    
    // Failable initializer
    init?(lessonId: String, title: String, status: LessonStatus) {
        // Validation using guard
        guard !title.isEmpty, lessonId.count >= 5 else {
            return nil
        }
        self.lessonId = lessonId
        self.title = title
        self.status = status
    }
}

class ProgressTracker {
    // Dictionary to store lessons
    var lessons: [String: Lesson] = [:]
    
    // Subscript to fetch or update Lesson.
    // Because Lesson is a reference type (class), you can fetch the object
    // and easily update its status like so: tracker["ID"]?.status = .completed
    subscript(lessonId: String) -> Lesson? {
        get {
            return lessons[lessonId]
        }
        set {
            lessons[lessonId] = newValue
        }
    }
    
    /*
    // (Optional Alternative) A specific subscript strictly tailored to update just the status
    subscript(statusFor lessonId: String) -> LessonStatus? {
        get { return lessons[lessonId]?.status }
        set {
            if let newStatus = newValue {
                lessons[lessonId]?.status = newStatus
            }
        }
    }
    */
    
    // Closure-based function to get failed lessons with a specific keyword
    func getFailedLessons(containing keyword: String) -> [Lesson] {
        return lessons.values.filter { lesson in
            // Pattern match to check if it's failed and extract the reason
            if case .failed(let reason) = lesson.status {
                // Use localized method to make lowercase/search mapping fully robust across platforms
                return reason.localizedCaseInsensitiveContains(keyword)
            }
            return false
        }
    }
}

// ============================================================
// EXAMPLE USAGE:
// ============================================================
let tracker = ProgressTracker()

// Adding new lessons to the tracker
if let l1 = Lesson(lessonId: "SWIFT01", title: "Protocols", status: .notStarted) {
    tracker[l1.lessonId] = l1
}
if let l2 = Lesson(lessonId: "SWIFT02", title: "Enums", status: .failed(reason: "Server timeout error")) {
    tracker[l2.lessonId] = l2
}
if let l3 = Lesson(lessonId: "SWIFT03", title: "Guard Let", status: .failed(reason: "Compile Error regarding Optionals")) {
    tracker[l3.lessonId] = l3
}

// 1. Updating status using the standard subscript reference
tracker["SWIFT01"]?.status = .inProgress

// 2. Updating status using the custom targeted subscript
// tracker[statusFor: "SWIFT01"] = .completed

// Testing closure-based filter
print("\n--- Failed Lessons containing 'error' ---")
let filtered = tracker.getFailedLessons(containing: "error")
for lesson in filtered {
    if case .failed(let reason) = lesson.status {
        print("-\(lesson.lessonId) | \(lesson.title): \(reason)")
    }
}

/*
============================================================
EXPLANATION:
1. Associated Value Enum: The `LessonStatus` enum utilizes `.failed(reason: String)` to dynamically hold a specific failure cause alongside its state.
2. Failable Initializers & Guard: The class `Lesson` uses a failable `init?`. A single `guard` statement validates multiple conditions concurrently (`!title.isEmpty`, `lessonId.count >= 5`), immediately protecting against malformed instantiation.
3. Subscripts: The `ProgressTracker` features dictionary-driven subscripts. By default, returning a class reference from a subscript natively allows direct property manipulation (`tracker["ID"]?.status`), successfully answering the prompt's explicit requirement to update the status via a subscript.
4. Higher-Order Closures: Inside `getFailedLessons`, `switch` pattern matching or `if case` concisely unpacks enum values mid-iteration inside the `.filter` closure, checking `.contains(keyword)` before grouping matching lessons into the returned array.
============================================================
*/
