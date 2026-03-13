import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var counterLabel: UILabel!    // Shows the counter value
    @IBOutlet weak var themeSwitch: UISwitch!    // Toggles light/dark theme
    @IBOutlet weak var themeLabel: UILabel!       // Shows "Light Mode" or "Dark Mode"

    var counter: Int = 0  // Stores the current counter value

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0
        counterLabel.text = "0"
        themeSwitch.isOn = false
        themeLabel.text = "Light Mode"
    }

    // "+" button tapped - increment by 1
    @IBAction func incrementTapped(_ sender: UIButton) {
        counter += 1
        counterLabel.text = "\(counter)"
    }

    // "-" button tapped - decrement by 1
    @IBAction func decrementTapped(_ sender: UIButton) {
        counter -= 1
        counterLabel.text = "\(counter)"
    }

    // "Reset" button tapped - set counter back to 0
    @IBAction func resetTapped(_ sender: UIButton) {
        counter = 0
        counterLabel.text = "0"
    }

    // Toggle light/dark theme
    @IBAction func themeToggle(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = UIColor.black
            counterLabel.textColor = UIColor.white
            themeLabel.textColor = UIColor.white
            themeLabel.text = "Dark Mode"
        } else {
            view.backgroundColor = UIColor.white
            counterLabel.textColor = UIColor.black
            themeLabel.textColor = UIColor.black
            themeLabel.text = "Light Mode"
        }
    }
}
