import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var addOnsStackView: UIStackView!
    @IBOutlet weak var grandTotalTextField: UITextField!
    
    var roomName: String = ""
    var roomPrice: Double = 0.0
    var selectedAddOns: [String] = []
    var addOnTotal: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Booking Confirmed"
        setupConfirmationDetails()
    }
    
    func setupConfirmationDetails() {
        roomNameLabel.text = "Room: \(roomName) (₹\(roomPrice))"
        
        for view in addOnsStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        if selectedAddOns.isEmpty {
            let label = UILabel()
            label.text = "No Add-ons Selected"
            addOnsStackView.addArrangedSubview(label)
        } else {
            for addOn in selectedAddOns {
                let label = UILabel()
                label.text = "• \(addOn)"
                addOnsStackView.addArrangedSubview(label)
            }
        }
        
        let grandTotal = roomPrice + addOnTotal
        grandTotalTextField.text = "₹\(grandTotal)"
        grandTotalTextField.isUserInteractionEnabled = false
    }
}
