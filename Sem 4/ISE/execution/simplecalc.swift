import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var num1Field: UITextField!   // First number input
    @IBOutlet weak var num2Field: UITextField!   // Second number input
    @IBOutlet weak var resultLabel: UILabel!     // Shows the calculation result

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Result will appear here"
    }

    // Helper to get both numbers, returns nil if invalid
    func getNumbers() -> (Double, Double)? {
        let text1 = num1Field.text ?? ""
        let text2 = num2Field.text ?? ""

        // Double() returns nil if the text isn't a valid number
        guard let n1 = Double(text1), let n2 = Double(text2) else {
            resultLabel.text = "Please enter valid numbers"
            return nil
        }
        return (n1, n2)
    }

    // Addition button tapped
    @IBAction func addTapped(_ sender: UIButton) {
        guard let (n1, n2) = getNumbers() else { return }
        resultLabel.text = "Result: \(n1 + n2)"
    }

    // Subtraction button tapped
    @IBAction func subtractTapped(_ sender: UIButton) {
        guard let (n1, n2) = getNumbers() else { return }
        resultLabel.text = "Result: \(n1 - n2)"
    }

    // Multiplication button tapped
    @IBAction func multiplyTapped(_ sender: UIButton) {
        guard let (n1, n2) = getNumbers() else { return }
        resultLabel.text = "Result: \(n1 * n2)"
    }

    // Division button tapped
    @IBAction func divideTapped(_ sender: UIButton) {
        guard let (n1, n2) = getNumbers() else { return }
        // Can't divide by zero
        if n2 == 0 {
            resultLabel.text = "Cannot divide by zero"
            return
        }
        resultLabel.text = "Result: \(String(format: "%.2f", n1 / n2))"
    }

    // Clear button - resets all fields
    @IBAction func clearTapped(_ sender: UIButton) {
        num1Field.text = ""
        num2Field.text = ""
        resultLabel.text = "Result will appear here"
    }
}
