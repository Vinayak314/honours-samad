import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var totalTextField: UITextField!
    
    var selectedItemsText: String = ""
    var totalAmount: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = selectedItemsText
        summaryLabel.numberOfLines = 0
        totalTextField.text = "Total: $\(totalAmount)"
    }
}
