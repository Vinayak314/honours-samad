import UIKit

class ViewController: UIViewController {

    // IBOutlets - connect storyboard UI elements to code
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var tempSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    var currentTempCelsius: Double = 0.0  // stored so tempToggle can access it
    var isCelsius: Bool = true

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        themeSwitch.isOn = false
        tempSwitch.isOn = true
        themeLabel.text = "Light Mode"
        tempLabel.text = "Celsius"
        weatherLabel.text = "Enter a city and tap Get Weather"
    }

    // Triggered when "Get Weather" button is tapped
    @IBAction func getWeather(_ sender: UIButton) {
        let city = cityField.text ?? ""  // ?? gives "" if text is nil

        if city.isEmpty {
            weatherLabel.text = "Please enter a city name"
            return
        }

        // Simulated weather data (in a real app, you'd call an API)
        let condition: String
        let temp: Double

        switch city.lowercased() {
        case "mumbai":
            condition = "sunny"
            temp = 34.0
        case "london":
            condition = "rainy"
            temp = 12.0
        case "tokyo":
            condition = "cloudy"
            temp = 22.0
        case "moscow":
            condition = "snowy"
            temp = -5.0
        case "delhi":
            condition = "thunderstorm"
            temp = 38.0
        default:
            condition = "sunny"
            temp = 25.0
        }

        currentTempCelsius = temp
        updateTempDisplay()

        // Image name must match condition string in Assets.xcassets
        let img = UIImage(named: condition)
        weatherImage.image = img
    }

    // Updates the label with temperature in the current unit (°C or °F)
    func updateTempDisplay() {
        let city = cityField.text ?? ""
        if isCelsius {
            weatherLabel.text = "\(city): \(currentTempCelsius)°C"
        } else {
            // Formula: F = (C × 9/5) + 32
            let fahrenheit = (currentTempCelsius * 9.0 / 5.0) + 32.0
            weatherLabel.text = "\(city): \(fahrenheit)°F"
        }
    }

    // Toggle light/dark theme
    @IBAction func themeToggle(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = UIColor.black
            weatherLabel.textColor = UIColor.white
            themeLabel.textColor = UIColor.white
            tempLabel.textColor = UIColor.white
            themeLabel.text = "Dark Mode"
        } else {
            view.backgroundColor = UIColor.white
            weatherLabel.textColor = UIColor.black
            themeLabel.textColor = UIColor.black
            tempLabel.textColor = UIColor.black
            themeLabel.text = "Light Mode"
        }
    }

    // Toggle Celsius / Fahrenheit
    @IBAction func tempToggle(_ sender: UISwitch) {
        if sender.isOn {
            isCelsius = true
            tempLabel.text = "Celsius"
        } else {
            isCelsius = false
            tempLabel.text = "Fahrenheit"
        }

        let city = cityField.text ?? ""
        if !city.isEmpty {
            updateTempDisplay()
        }
    }
}
