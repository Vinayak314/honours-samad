//
//  ConfirmationViewController.swift
//  setd
//
//  Created by KJSCE on 13/05/26.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!

    var name: String?
    var email: String?
    var phone: String?
    var isDarkMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Name: \(name ?? "")"
        emailLabel.text = "Email: \(email ?? "")"
        phoneLabel.text = "Phone: \(phone ?? "")"
        darkModeLabel.text = "Dark Mode: \(isDarkMode ? "Enabled" : "Disabled")"
    }
}
