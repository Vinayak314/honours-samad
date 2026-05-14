//
//  ViewController.swift
//  setc
//
//  Created by KJSCE on 13/05/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var subscriptionSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageSlider.minimumValue = 1
        ageSlider.maximumValue = 100
        ageSlider.value = 18
        updateAgeLabel()
    }

    @IBAction func ageSliderChanged(_ sender: UISlider) {
        updateAgeLabel()
    }
    
    func updateAgeLabel() {
        ageLabel.text = "Selected Age: \(Int(ageSlider.value))"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destVC = segue.destination as? DetailsViewController {
                let gender = genderSwitch.isOn ? "Male" : "Female"
                let age = Int(ageSlider.value)
                let subscribed = subscriptionSwitch.isOn ? "Yes" : "No"
                
                destVC.detailsText = """
                Name: \(nameTextField.text ?? "")
                Gender: \(gender)
                Email: \(emailTextField.text ?? "")
                Age: \(age)
                Newsletter Subscription: \(subscribed)
                """
            }
        }
    }
}
