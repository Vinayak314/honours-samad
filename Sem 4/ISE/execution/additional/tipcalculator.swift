import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var billField: UITextField!       // User enters the bill amount
    @IBOutlet weak var tipSlider: UISlider!           // Slider to select tip percentage
    @IBOutlet weak var tipPercentLabel: UILabel!      // Shows current tip %
    @IBOutlet weak var tipAmountLabel: UILabel!       // Shows calculated tip
    @IBOutlet weak var totalLabel: UILabel!           // Shows bill + tip
    @IBOutlet weak var splitStepper: UIStepper!       // Stepper to choose number of people
    @IBOutlet weak var splitCountLabel: UILabel!      // Shows number of people
    @IBOutlet weak var perPersonLabel: UILabel!       // Shows amount per person

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()

        // Tip slider: 0% to 30%, default 15%
        tipSlider.minimumValue = 0
        tipSlider.maximumValue = 30
        tipSlider.value = 15

        // Stepper: 1 to 10 people, default 1
        splitStepper.minimumValue = 1
        splitStepper.maximumValue = 10
        splitStepper.value = 1

        tipPercentLabel.text = "Tip: 15%"
        splitCountLabel.text = "Split: 1"
        tipAmountLabel.text = "Tip: ₹0.00"
        totalLabel.text = "Total: ₹0.00"
        perPersonLabel.text = "Per Person: ₹0.00"
    }

    // Recalculate everything when tip slider changes
    @IBAction func tipSliderChanged(_ sender: UISlider) {
        let percent = Int(sender.value)
        tipPercentLabel.text = "Tip: \(percent)%"
        calculateTip()
    }

    // Recalculate when stepper value changes
    @IBAction func stepperChanged(_ sender: UIStepper) {
        let people = Int(sender.value)
        splitCountLabel.text = "Split: \(people)"
        calculateTip()
    }

    // "Calculate" button tapped
    @IBAction func calculateTapped(_ sender: UIButton) {
        calculateTip()
    }

    // Helper function that does all the math
    func calculateTip() {
        let billText = billField.text ?? ""

        guard let bill = Double(billText) else {
            tipAmountLabel.text = "Enter a valid bill amount"
            totalLabel.text = ""
            perPersonLabel.text = ""
            return
        }

        let tipPercent = Double(tipSlider.value) / 100.0
        let tipAmount = bill * tipPercent
        let total = bill + tipAmount
        let people = Int(splitStepper.value)
        let perPerson = total / Double(people)

        // String(format:) rounds to 2 decimal places
        tipAmountLabel.text = "Tip: ₹\(String(format: "%.2f", tipAmount))"
        totalLabel.text = "Total: ₹\(String(format: "%.2f", total))"
        perPersonLabel.text = "Per Person: ₹\(String(format: "%.2f", perPerson))"
    }

    // "Reset" button clears everything
    @IBAction func resetTapped(_ sender: UIButton) {
        billField.text = ""
        tipSlider.value = 15
        splitStepper.value = 1
        tipPercentLabel.text = "Tip: 15%"
        splitCountLabel.text = "Split: 1"
        tipAmountLabel.text = "Tip: ₹0.00"
        totalLabel.text = "Total: ₹0.00"
        perPersonLabel.text = "Per Person: ₹0.00"
    }
}
