import UIKit

enum Operation {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {

    @IBOutlet weak var num1Field: UITextField!
    @IBOutlet weak var num2Field: UITextField!
    @IBOutlet weak var operationControl: UISegmentedControl!
    
    var calculationResult: Double?
    var divisionByZeroError: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Demonstrate calling the calculate function with different operations and numbers
        print("Demo Add (10 + 5): \(String(describing: calculate(num1: 10, num2: 5, operation: .add)))")
        print("Demo Subtract (10 - 5): \(String(describing: calculate(num1: 10, num2: 5, operation: .subtract)))")
        print("Demo Multiply (10 * 5): \(String(describing: calculate(num1: 10, num2: 5, operation: .multiply)))")
        print("Demo Division by Zero (10 / 0): \(String(describing: calculate(num1: 10, num2: 0, operation: .divide)))")
    }

    func calculate(num1: Double, num2: Double, operation: Operation) -> Double? {
        // Define a dictionary where keys are Operation enum cases and values are closures that return Double?
        let operationsDict: [Operation: (Double, Double) -> Double?] = [
            .add: { $0 + $1 },
            .subtract: { $0 - $1 },
            .multiply: { $0 * $1 },
            .divide: { $1 == 0 ? nil : $0 / $1 }
        ]
        
        // Use a switch statement on the Operation to retrieve the closure.
        // Using `flatMap` with trailing closure syntax to satisfy the requirement of "calling closures indirectly with trailing closure syntax".
        switch operation {
        case .add:
            return operationsDict[.add].flatMap { $0(num1, num2) }
        case .subtract:
            return operationsDict[.subtract].flatMap { $0(num1, num2) }
        case .multiply:
            return operationsDict[.multiply].flatMap { $0(num1, num2) }
        case .divide:
            return operationsDict[.divide].flatMap { $0(num1, num2) }
        }
    }

    @IBAction func calculateTapped(_ sender: UIButton) {
        guard let num1Str = num1Field.text, let num1 = Double(num1Str),
              let num2Str = num2Field.text, let num2 = Double(num2Str) else {
            return
        }
        
        var selectedOperation: Operation = .add
        switch operationControl.selectedSegmentIndex {
        case 0: selectedOperation = .add
        case 1: selectedOperation = .subtract
        case 2: selectedOperation = .multiply
        case 3: selectedOperation = .divide
        default: break
        }
        
        calculationResult = calculate(num1: num1, num2: num2, operation: selectedOperation)
        divisionByZeroError = (selectedOperation == .divide && num2 == 0)
        
        performSegue(withIdentifier: "showResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            if let destinationVC = segue.destination as? ResultViewController {
                destinationVC.result = calculationResult
                destinationVC.isDivisionByZero = divisionByZeroError
            }
        }
    }
}
