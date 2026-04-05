// ============================================================
// Q15: OptionSet Protocol
// ============================================================
// Implement a permissions system using OptionSet:
//   1. Create a struct `FilePermissions: OptionSet` with raw type Int.
//      Define options: read (1), write (2), execute (4).
//      Define compound options: readWrite, all.
//   2. Create a struct `UserRole: OptionSet` with raw type Int.
//      Define roles: viewer (1), editor (2), admin (4), superAdmin (8).
//      Define compounds: staff = [viewer, editor], fullAccess = all.
//   3. Create a struct `User` with name, role (UserRole), filePermissions.
//   4. Write a function that checks if a user can perform specific actions
//      based on their permissions (using .contains, .union, .intersection).
//   5. Demonstrate creating users, combining permissions, and checking access.
// ============================================================

struct FilePermissions: OptionSet {
    var rawValue: Int
    static let read = FilePermissions(rawValue: 1)
    static let write = FilePermissions(rawValue: 2)
    static let execute = FilePermissions(rawValue: 4)
    static let readWrite: FilePermissions = [.read, .write]
    static let all: FilePermissions = [.read, .write, .execute]
}

struct UserRole: OptionSet {
    var rawValue: Int
    static let viewer = UserRole(rawValue: 1)
    static let editor = UserRole(rawValue: 2)
    static let admin = UserRole(rawValue: 4)
    static let superAdmin = UserRole(rawValue: 8)
    static let staff: UserRole = [.viewer, .editor]
    static let fullAccess: UserRole = [.viewer, .editor, .admin, .superAdmin]
}

struct User { var name: String; var role: UserRole; var filePermissions: FilePermissions }

func checkAction(user: User, reqPerm: FilePermissions, reqRole: UserRole) -> Bool { 
    return user.filePermissions.contains(reqPerm) && user.role.contains(reqRole) 
}

var u = User(name: "A", role: .staff, filePermissions: .readWrite)
print("Can write & edit?", checkAction(user: u, reqPerm: .write, reqRole: .editor))

u.filePermissions.insert(.execute)
print("Added execute permission")

let comb = u.filePermissions.union(.all)
let inter = u.filePermissions.intersection(.read)
print("Has read after inter?", inter.contains(.read))

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- OptionSet: Standardly binds multi-flag properties leveraging raw integer underlying capabilities sequentially spacing Boolean options structurally native mapped.
- Bitwise Logic Sets: Smoothly enables contextual permission modifications through unified `contains()`, `insert()`, and `.union()` Set algorithms removing verbose Boolean variable configurations natively.
*/
