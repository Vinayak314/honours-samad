import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var result: Double?
    var isDivisionByZero: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDivisionByZero {
            resultLabel.text = "Error: Division by zero"
            resultLabel.textColor = .systemRed
        } else if let res = result {
            resultLabel.text = "Result: \(res)"
            resultLabel.textColor = .label
        } else {
            resultLabel.text = "Invalid input"
            resultLabel.textColor = .systemRed
        }
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
