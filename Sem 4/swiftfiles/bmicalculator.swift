import UIKit

class ViewController: UIViewController {

    // IBOutlets - connect storyboard UI elements to code
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()

        // Height slider: 100cm to 220cm, default 170cm
        heightSlider.minimumValue = 100
        heightSlider.maximumValue = 220
        heightSlider.value = 170

        // Weight slider: 30kg to 200kg, default 70kg
        weightSlider.minimumValue = 30
        weightSlider.maximumValue = 200
        weightSlider.value = 70

        genderSwitch.isOn = true
        genderLabel.text = "Male"
        heightLabel.text = "Height: 170 cm"
        weightLabel.text = "Weight: 70 kg"
        resultLabel.text = "Tap Calculate BMI"
    }

    // Update height label when slider moves
    @IBAction func heightChanged(_ sender: UISlider) {
        let height = Int(sender.value)
        heightLabel.text = "Height: \(height) cm"
    }

    // Update weight label when slider moves
    @IBAction func weightChanged(_ sender: UISlider) {
        let weight = Int(sender.value)
        weightLabel.text = "Weight: \(weight) kg"
    }

    // Toggle gender label
    @IBAction func genderToggle(_ sender: UISwitch) {
        if sender.isOn {
            genderLabel.text = "Male"
        } else {
            genderLabel.text = "Female"
        }
    }

    // Triggered when "Calculate BMI" button is tapped
    @IBAction func calculateBMI(_ sender: UIButton) {
        let age = ageField.text ?? ""

        if age.isEmpty {
            resultLabel.text = "Please enter your age"
            return
        }

        let heightCm = Double(heightSlider.value)
        let weightKg = Double(weightSlider.value)

        // Convert height from cm to metres
        let heightM = heightCm / 100.0

        // BMI formula: weight(kg) / height(m)²
        let bmi = weightKg / (heightM * heightM)

        // Determine BMI category
        let category: String
        if bmi < 18.5 {
            category = "Underweight"
        } else if bmi < 25.0 {
            category = "Normal Weight"
        } else if bmi < 30.0 {
            category = "Overweight"
        } else {
            category = "Obese"
        }

        let gender = genderSwitch.isOn ? "Male" : "Female"

        // Display result rounded to 1 decimal place
        resultLabel.text = "\(gender), Age: \(age)\nBMI: \(String(format: "%.1f", bmi))\nCategory: \(category)"
    }
}
