import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!
    
    var detailsText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = detailsText
        detailsLabel.numberOfLines = 0
    }
}
