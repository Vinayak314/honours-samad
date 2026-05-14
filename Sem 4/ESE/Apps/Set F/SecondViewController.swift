import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageName: String?
    var imageTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title label
        titleLabel.text = imageTitle
        
        // Display the image passed from ViewController
        if let imgName = imageName, let image = UIImage(named: imgName) {
            imageView.image = image
        } else {
            // Provide a system fallback image if the asset is not found
            imageView.image = UIImage(systemName: "photo")
        }
    }
}
