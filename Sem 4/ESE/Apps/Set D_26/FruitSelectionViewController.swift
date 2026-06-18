import UIKit

class FruitSelectionViewController: UIViewController {

    @IBOutlet weak var selectedFruitLabel: UILabel!
    @IBOutlet weak var fruitImageView: UIImageView!

    var selectedFruitName: String = ""
    var selectedFruitImageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Fruit"
        selectedFruitLabel.text = "No fruit selected"
        fruitImageView.image = nil
    }

    @IBAction func appleTapped(_ sender: UIButton) {
        selectFruit(name: "Apple", imageName: "apple")
    }

    @IBAction func bananaTapped(_ sender: UIButton) {
        selectFruit(name: "Banana", imageName: "banana")
    }

    @IBAction func mangoTapped(_ sender: UIButton) {
        selectFruit(name: "Mango", imageName: "mango")
    }

    func selectFruit(name: String, imageName: String) {
        selectedFruitName = name
        selectedFruitImageName = imageName
        selectedFruitLabel.text = "Selected: \(name)"
        fruitImageView.image = UIImage(named: imageName)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? FruitDetailViewController {
            detailVC.fruitName = selectedFruitName
            detailVC.fruitImageName = selectedFruitImageName
        }
    }
}
