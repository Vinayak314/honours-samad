import UIKit

class FruitDetailViewController: UIViewController {

    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var fruitImageView: UIImageView!

    var fruitName: String = ""
    var fruitImageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fruit of the Day"
        fruitNameLabel.text = fruitName
        fruitImageView.image = UIImage(named: fruitImageName)
    }
}
