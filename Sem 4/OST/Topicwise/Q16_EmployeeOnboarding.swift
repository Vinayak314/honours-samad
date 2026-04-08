// ============================================================
// QUESTION:
// Build an employee onboarding system where each employee must be assigned a role.
// - Define an enum Role with cases: .developer, .designer, .manager, .intern(level: Int)
// - Create a class Employee with id, name, role: Role
// - Initializer must validate that name is not empty and role is not .intern(level: 0) using guard. If invalid, return nil.
// - Create a class Company that stores employees in a dictionary.
//     - Use subscript to fetch/update employee details by ID.
//     - Provide a closure-based filter to return only interns or developers.
// ============================================================

enum Role {
    case developer
    case designer
    case manager
    case intern(level: Int)
}

class Employee {
    let id: Int
    var name: String
    var role: Role
    
    // Failable initializer
    init?(id: Int, name: String, role: Role) {
        // Validate that name is not empty using guard
        guard !name.isEmpty else { return nil }
        
        // Validate that role is not .intern(level: 0) using guard
        if case .intern(let level) = role {
            guard level != 0 else { return nil }
        }
        
        self.id = id
        self.name = name
        self.role = role
    }
}

class Company {
    // Stores employees in a dictionary with ID as key
    var employees: [Int: Employee] = [:]
    
    // Subscript to fetch/update employee details by ID
    subscript(id: Int) -> Employee? {
        get {
            return employees[id]
        }
        set(newEmployee) {
            employees[id] = newEmployee
        }
    }
    
    // Closure-based filter to return only interns or developers
    func filterInternsAndDevelopers() -> [Employee] {
        return employees.values.filter { employee in
            switch employee.role {
            case .developer, .intern:
                return true
            default:
                return false
            }
        }
    }
}

// ============================================================
// EXAMPLE USAGE:
// ============================================================
let company = Company()

if let emp1 = Employee(id: 1, name: "Alice", role: .developer) {
    company[emp1.id] = emp1
}

if let emp2 = Employee(id: 2, name: "Bob", role: .designer) {
    company[emp2.id] = emp2
}

if let emp3 = Employee(id: 3, name: "Charlie", role: .intern(level: 1)) {
    company[emp3.id] = emp3
}

// These initializations will fail and return nil
let invalidIntern = Employee(id: 4, name: "Dave", role: .intern(level: 0))
let emptyNameEmp = Employee(id: 5, name: "", role: .manager)

let internsAndDevs = company.filterInternsAndDevelopers()
print("Filtered Employees (Interns & Developers):")
for emp in internsAndDevs {
    print("- \(emp.name) (ID: \(emp.id))")
}

// ============================================================
// DEMONSTRATING HOW `get` WORKS IN SUBSCRIPT:
// ============================================================
print("\n--- Testing Subscript `get` ---")
// When you access a value using bracket notation like `company[1]`, 
// Swift implicitly triggers the `get { ... }` block defined inside the subscript.
// It hands over the 'id' (1 in this case), and our code returns the corresponding Employee object.
let searchID = 1
if let fetchedEmployee = company[searchID] { 
    print("Employee Found using `get` - Name: \(fetchedEmployee.name), ID: \(fetchedEmployee.id)")
} else {
    print("Employee with ID \(searchID) not found.")
}

// ============================================================
// INTERACTIVE USER INPUT:
// ============================================================
print("\n--- Enter Employee Details ---")
print("Enter Employee ID: ", terminator: "")
if let idString = readLine(), let id = Int(idString) {
    print("Enter Employee Name: ", terminator: "")
    if let name = readLine(), !name.isEmpty {
        print("Choose Role (1: Developer, 2: Designer, 3: Manager, 4: Intern): ", terminator: "")
        if let roleString = readLine(), let roleChoice = Int(roleString) {
            
            var chosenRole: Role?
            switch roleChoice {
            case 1: chosenRole = .developer
            case 2: chosenRole = .designer
            case 3: chosenRole = .manager
            case 4:
                print("Enter Intern Level: ", terminator: "")
                if let levelStr = readLine(), let level = Int(levelStr) {
                    chosenRole = .intern(level: level)
                }
            default:
                print("Invalid role choice.")
            }
            
            if let role = chosenRole {
                if let newEmployee = Employee(id: id, name: name, role: role) {
                    company[newEmployee.id] = newEmployee // This calls the 'set' block of the subscript
                    print("Successfully added: \(newEmployee.name) to the company.")
                } else {
                    print("Failed to add employee. Validations failed (e.g., empty name or intern level 0).")
                }
            }
        } else {
            print("Invalid Role Choice.")
        }
    } else {
        print("Name cannot be empty.")
    }
} else {
    print("Invalid ID.")
}


/*
============================================================
EXPLANATION:
1. Enum with Associated Value: Defined `Role` where the `.intern` case includes an associated `Int` value to represent the intern's level.
2. Failable Initializer (`init?`): The `Employee` class uses a failable initializer to ensure objects are only instantiated with a perfectly valid state. It utilizes a `guard` statement to verify that the `name` is not empty. If the role is matched to an `.intern`, it securely uses another `guard` statement to fail initialization if the specific level associated matches `0`.
3. Dictionary Storage & Subscripts: The `Company` class maintains an `[Int: Employee]` dictionary to catalog employees effectively by their `id`. It implements a custom `subscript` that delegates to the dictionary's native subscript operations, providing clean array-like syntax for updating or fetching (e.g., `company[1] = newEmployee`).
4. Closure-Based Filter: The `filterInternsAndDevelopers` method elegantly complies by employing Swift's built-in `.filter` higher-order function! By passing an underlying closure containing a `switch` statement mechanism, it iterates appropriately to filter out and return an array strictly containing bearers of `.developer` or `.intern` designations.
============================================================
*/
