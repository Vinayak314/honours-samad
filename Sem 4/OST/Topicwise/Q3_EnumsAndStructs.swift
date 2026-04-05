// ============================================================
// Q3: Enums with Associated Values and Structs
// ============================================================
// Design a simple Shape system:
//   1. Create an enum `Shape` with cases:
//       - circle(radius: Double)
//       - rectangle(width: Double, height: Double)
//       - triangle(base: Double, height: Double)
//   2. Add a computed property `area` to the enum that calculates
//      the area for each shape.
//   3. Add a computed property `description` that returns a readable string.
//   4. Create a struct `Canvas` that holds an array of Shape.
//      - Add a method `totalArea()` that returns the sum of all shape areas.
//      - Add a method `largestShape()` that returns the shape with the max area.
//   5. Create a canvas with at least 4 shapes and demonstrate the methods.
// ============================================================

enum Shape {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)
    case triangle(base: Double, height: Double)
    
    var area: Double {
        switch self {
        case .circle(let r): return 3.14159 * r * r
        case .rectangle(let w, let h): return w * h
        case .triangle(let b, let h): return 0.5 * b * h
        }
    }
    
    var description: String { "Shape with area \(area)" }
}

struct Canvas {
    var shapes: [Shape]
    
    func totalArea() -> Double {
        var sum = 0.0
        for s in shapes { sum += s.area }
        return sum
    }
    func largestShape() -> Shape? {
        return shapes.max { $0.area < $1.area }
    }
}

let c = Canvas(shapes: [.circle(radius: 5), .rectangle(width: 4, height: 5), .triangle(base: 3, height: 4)])
print("Total Area:", c.totalArea())
print("Largest Shape:", c.largestShape()?.description ?? "none")

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Enums with Associated Values: Instead of just acting as basic flags, enum cases (`circle`, `rectangle`) store distinct values (radii, dimensions) alongside the case itself.
- Pattern Matching via Switch: Enums are exhaustively matched in a `switch` on `self` to execute explicit logic based on which specific shape instance is selected.
*/
