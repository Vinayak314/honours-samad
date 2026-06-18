import UIKit

class AddOnsViewController: UIViewController {

    @IBOutlet weak var breakfastSwitch: UISwitch!
    @IBOutlet weak var airportTransferSwitch: UISwitch!
    @IBOutlet weak var spaSwitch: UISwitch!
    @IBOutlet weak var runningTotalLabel: UILabel!
    
    var roomName: String = ""
    var roomPrice: Double = 0.0
    
    var selectedAddOns: [String] = []
    var addOnTotal: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add-ons"
        updateRunningTotal()
    }

    @IBAction func addOnSwitchToggled(_ sender: UISwitch) {
        updateRunningTotal()
    }
    
    func updateRunningTotal() {
        selectedAddOns.removeAll()
        addOnTotal = 0.0
        
        if breakfastSwitch.isOn {
            selectedAddOns.append("Breakfast")
            addOnTotal += 500.0
        }
        if airportTransferSwitch.isOn {
            selectedAddOns.append("Airport Transfer")
            addOnTotal += 800.0
        }
        if spaSwitch.isOn {
            selectedAddOns.append("Spa")
            addOnTotal += 1200.0
        }
        
        runningTotalLabel.text = "Add-ons Total: ₹\(addOnTotal)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ConfirmationViewController {
            destinationVC.roomName = roomName
            destinationVC.roomPrice = roomPrice
            destinationVC.selectedAddOns = selectedAddOns
            destinationVC.addOnTotal = addOnTotal
        }
    }
}
