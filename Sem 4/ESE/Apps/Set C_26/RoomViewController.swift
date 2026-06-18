import UIKit

class RoomViewController: UIViewController {

    @IBOutlet weak var standardSwitch: UISwitch!
    @IBOutlet weak var deluxeSwitch: UISwitch!
    @IBOutlet weak var suiteSwitch: UISwitch!
    @IBOutlet weak var selectedRoomLabel: UILabel!
    
    var selectedRoomName: String = ""
    var selectedRoomPrice: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Room"
        updateSelectedRoom()
    }

    @IBAction func roomSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            if sender != standardSwitch { standardSwitch.setOn(false, animated: true) }
            if sender != deluxeSwitch { deluxeSwitch.setOn(false, animated: true) }
            if sender != suiteSwitch { suiteSwitch.setOn(false, animated: true) }
        }
        updateSelectedRoom()
    }
    
    func updateSelectedRoom() {
        if standardSwitch.isOn {
            selectedRoomName = "Standard"
            selectedRoomPrice = 2000.0
            selectedRoomLabel.text = "Selected: Standard (₹2000)"
        } else if deluxeSwitch.isOn {
            selectedRoomName = "Deluxe"
            selectedRoomPrice = 3500.0 
            selectedRoomLabel.text = "Selected: Deluxe (₹3500)"
        } else if suiteSwitch.isOn {
            selectedRoomName = "Suite"
            selectedRoomPrice = 6000.0
            selectedRoomLabel.text = "Selected: Suite (₹6000)"
        } else {
            selectedRoomName = "None"
            selectedRoomPrice = 0.0
            selectedRoomLabel.text = "Selected: None"
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddOnsViewController {
            destinationVC.roomName = selectedRoomName
            destinationVC.roomPrice = selectedRoomPrice
        }
    }
    
    @IBAction func unwindToRoomSelection(_ unwindSegue: UIStoryboardSegue) {
        standardSwitch.setOn(false, animated: true)
        deluxeSwitch.setOn(false, animated: true)
        suiteSwitch.setOn(false, animated: true)
        updateSelectedRoom()
    }
}
