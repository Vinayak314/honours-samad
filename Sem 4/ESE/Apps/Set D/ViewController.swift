//
//  ViewController.swift
//  setd
//
//  Created by KJSCE on 13/05/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var darkModeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup initial UI
        profileImageView.image = UIImage(systemName: "person.circle.fill")
    }

    @IBAction func darkModeSwitchToggled(_ sender: UISwitch) {
        // Toggle dark mode for the app window
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showConfirmation" {
            if let destinationVC = segue.destination as? ConfirmationViewController {
                destinationVC.name = nameTextField.text
                destinationVC.email = emailTextField.text
                destinationVC.phone = phoneTextField.text
                destinationVC.isDarkMode = darkModeSwitch.isOn
            }
        }
    }
}
