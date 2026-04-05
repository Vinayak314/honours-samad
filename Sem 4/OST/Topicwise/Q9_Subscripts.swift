// ============================================================
// Q9: Subscripts and Methods
// ============================================================
// Implement a Matrix struct:
//   1. Create a struct `Matrix` that stores a 2D grid of Double values
//      using a flat array internally.
//   2. Implement a subscript `subscript(row: Int, col: Int) -> Double`
//      with both get and set, so you can access elements as matrix[1, 2].
//   3. Add a method `transpose() -> Matrix` that returns the transposed matrix.
//   4. Add a method `display()` that prints the matrix in a formatted way.
//   5. Add a subscript `subscript(row row: Int) -> [Double]` that returns
//      an entire row as an array.
//   6. Demonstrate creation, element access, row access, and transposition.
// ============================================================

struct Matrix {
    let rows: Int, cols: Int
    var grid: [Double]
    
    subscript(row: Int, col: Int) -> Double {
        get { return grid[row * cols + col] }
        set { grid[row * cols + col] = newValue }
    }
    
    func transpose() -> Matrix {
        var t = Matrix(rows: cols, cols: rows, grid: Array(repeating: 0, count: rows * cols))
        for r in 0..<rows {
            for c in 0..<cols { t[c, r] = self[r, c] }
        }
        return t
    }
    
    func display() { print("Matrix:", grid) }
    
    subscript(row row: Int) -> [Double] {
        let start = row * cols
        return Array(grid[start..<(start + cols)])
    }
}

var m = Matrix(rows: 2, cols: 2, grid: [1,2,3,4])
print("Element:", m[0, 1])

m.transpose().display()

print("Row 1:", m[row: 1])

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Subscripts: Allows defining bracketed access natively `[row, col]` upon a custom data structure. 
- Get/Set Overrides: Interlocks custom execution whenever a property explicitly fetches or overwrites data contextually inside your Matrix boundary limitations.
*/
