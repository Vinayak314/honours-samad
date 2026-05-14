import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Main screen loaded
    }

    // Called right before the segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SecondViewController,
              let button = sender as? UIButton else { return }
        
        // Retrieve the title of the tapped button
        let title = button.titleLabel?.text ?? ""
        destinationVC.imageTitle = title
        
        // Pass a corresponding image name based on the button title
        // Make sure to add these images to your Assets.xcassets folder
        switch title {
        case "Nature":
            destinationVC.imageName = "nature_image"
        case "City":
            destinationVC.imageName = "city_image"
        case "Space":
            destinationVC.imageName = "space_image"
        default:
            destinationVC.imageName = "default_image"
        }
    }
}
