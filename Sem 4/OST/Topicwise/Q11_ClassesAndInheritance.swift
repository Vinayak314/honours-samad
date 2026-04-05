// ============================================================
// Q11: Classes, Properties, Methods, Reference Semantics,
//      Inheritance, and deinit
// ============================================================
// Build a vehicle hierarchy:
//   1. Create a base class `Vehicle` with:
//       - Properties: make (String), model (String), year (Int),
//         isRunning (Bool, default false)
//       - A designated initializer
//       - Methods: start(), stop() that toggle isRunning and print status
//       - A method `info() -> String`
//       - A deinit that prints when the vehicle is deallocated
//   2. Create a subclass `Car: Vehicle` with:
//       - Additional property: numberOfDoors (Int)
//       - Override info() to include door count
//   3. Create a subclass `ElectricCar: Car` with:
//       - Additional property: batteryLevel (Double, 0–100)
//       - A method `charge()` that sets battery to 100
//       - Override start() to check battery > 0 before starting
//       - Override info()
//   4. Demonstrate reference semantics: assign one variable to another,
//      modify through one, observe the change through the other.
//   5. Demonstrate deinit by creating an instance in a limited scope.
// ============================================================

class Vehicle {
    var make, model: String, year: Int, isRunning = false
    init(make: String, model: String, year: Int) { self.make=make; self.model=model; self.year=year }
    func start() { isRunning = true }
    func stop() { isRunning = false }
    func info() -> String { "\(year) \(make) \(model)" }
    deinit { print("\(make) deallocated") }
}

class Car: Vehicle {
    var numberOfDoors: Int
    init(make: String, model: String, year: Int, doors: Int) {
        self.numberOfDoors = doors
        super.init(make: make, model: model, year: year)
    }
    override func info() -> String { "\(super.info()) with \(numberOfDoors) doors" }
}

class ElectricCar: Car {
    var batteryLevel: Double
    init(make: String, model: String, year: Int, doors: Int, battery: Double) {
        self.batteryLevel = battery
        super.init(make: make, model: model, year: year, doors: doors)
    }
    func charge() { batteryLevel = 100 }
    override func start() { if batteryLevel > 0 { super.start() } }
    override func info() -> String { "\(super.info()) Battery: \(batteryLevel)%" }
}

var v1 = Vehicle(make: "Ford", model: "F150", year: 2020)
var v2 = v1
v1.year = 2021
print("v2 year after v1 change:", v2.year) // 2021 (Reference semantics)

do { let temp = Vehicle(make: "TempTest", model: "A", year: 1) } // Triggers deinit

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Inheritance: Subclasses intrinsically obtain inherited `Vehicle` properties natively permitting object overriding extending structural complexity efficiently.
- Reference Semantics: Unlike structs, variables instantiated by a Class share a single reference pointing directly toward identical allocations. Altering logic against `v1` visibly mutates data across `v2`.
- Deinitializers (`deinit`): Explicitly triggers pre-deallocation cleanup processes natively verifiable through standard Automatic Reference Counting (ARC).
*/
