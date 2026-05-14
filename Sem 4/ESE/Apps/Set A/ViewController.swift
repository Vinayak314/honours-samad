import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var item1Label: UILabel!
    @IBOutlet weak var item1Switch: UISwitch!
    
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item2Switch: UISwitch!
    
    @IBOutlet weak var item3Label: UILabel!
    @IBOutlet weak var item3Switch: UISwitch!
    
    let prices = ["Pizza": 12.0, "Burger": 8.0, "Pasta": 10.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        item1Label.text = "Pizza - $12"
        item2Label.text = "Burger - $8"
        item3Label.text = "Pasta - $10"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSummary", let destVC = segue.destination as? SummaryViewController {
            var selectedItems: [String] = []
            var total: Double = 0.0
            
            if item1Switch.isOn {
                selectedItems.append("Pizza")
                total += prices["Pizza"] ?? 0
            }
            if item2Switch.isOn {
                selectedItems.append("Burger")
                total += prices["Burger"] ?? 0
            }
            if item3Switch.isOn {
                selectedItems.append("Pasta")
                total += prices["Pasta"] ?? 0
            }
            
            destVC.selectedItemsText = selectedItems.isEmpty ? "None selected" : selectedItems.joined(separator: "\n")
            destVC.totalAmount = total
        }
    }
}
