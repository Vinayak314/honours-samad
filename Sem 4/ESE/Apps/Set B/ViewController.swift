import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ensure switch reflects the current style if opened
        darkModeSwitch.isOn = traitCollection.userInterfaceStyle == .dark
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // Simple validation to ensure username is provided
        if let username = usernameTextField.text, !username.isEmpty {
            performSegue(withIdentifier: "showDetails", sender: self)
        } else {
            // Optional: Show alert if empty
            let alert = UIAlertController(title: "Error", message: "Please enter a username.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // Clear both text fields
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func darkModeSwitchChanged(_ sender: UISwitch) {
        // Toggle Dark/Light mode preference
        if sender.isOn {
            overrideUserInterfaceStyle = .dark
            navigationController?.overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
            navigationController?.overrideUserInterfaceStyle = .light
        }
    }
    
    // Pass data to DetailsViewController before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destinationVC = segue.destination as? DetailsViewController {
                destinationVC.username = usernameTextField.text
            }
        }
    }
}
