//
//  ViewController.swift
//  q2
//
//  Created by KJSCE on 13/05/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTextView.layer.borderColor = UIColor.systemGray4.cgColor
        commentsTextView.layer.borderWidth = 1.0
        commentsTextView.layer.cornerRadius = 8.0
        
        ratingSlider.minimumValue = 1
        ratingSlider.maximumValue = 5
        ratingSlider.value = 3
        ratingValueLabel.text = "Selected Rating: 3"
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        ratingValueLabel.text = "Selected Rating: \(Int(roundedValue))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            if let destinationVC = segue.destination as? ResultViewController {
                destinationVC.name = nameTextField.text ?? ""
                destinationVC.rating = Int(ratingSlider.value)
                destinationVC.comments = commentsTextView.text ?? ""
            }
        }
    }
}

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var name: String = ""
    var rating: Int = 3
    var comments: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.numberOfLines = 0
        resultLabel.text = """
        Name: \(name)
        Rating: \(rating)
        Comments: \(comments)
        """
    }
}
