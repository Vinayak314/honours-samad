import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the entered details using UILabel
        if let user = username {
            detailsLabel.text = "Welcome, \(user)!"
        } else {
            detailsLabel.text = "Welcome!"
        }
    }
}
