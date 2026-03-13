import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var taskField: UITextField!       // User types a task here
    @IBOutlet weak var taskListLabel: UILabel!        // Displays all tasks
    @IBOutlet weak var countLabel: UILabel!           // Shows total task count
    @IBOutlet weak var statusLabel: UILabel!          // Shows last action performed

    // Array to store all tasks
    var tasks: [String] = []

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        taskListLabel.text = "No tasks yet"
        countLabel.text = "Tasks: 0"
        statusLabel.text = ""
        // Allow label to show multiple lines
        taskListLabel.numberOfLines = 0
    }

    // "Add" button tapped - adds a new task
    @IBAction func addTapped(_ sender: UIButton) {
        let task = taskField.text ?? ""

        if task.isEmpty {
            statusLabel.text = "Please enter a task"
            return
        }

        // Append to array and refresh display
        tasks.append(task)
        taskField.text = ""
        statusLabel.text = "Added: \(task)"
        updateDisplay()
    }

    // "Remove Last" button tapped - removes the last task
    @IBAction func removeLastTapped(_ sender: UIButton) {
        if tasks.isEmpty {
            statusLabel.text = "No tasks to remove"
            return
        }

        let removed = tasks.removeLast()
        statusLabel.text = "Removed: \(removed)"
        updateDisplay()
    }

    // "Clear All" button tapped - removes everything
    @IBAction func clearAllTapped(_ sender: UIButton) {
        tasks.removeAll()
        statusLabel.text = "All tasks cleared"
        updateDisplay()
    }

    // Helper to refresh the task list label and count
    func updateDisplay() {
        countLabel.text = "Tasks: \(tasks.count)"

        if tasks.isEmpty {
            taskListLabel.text = "No tasks yet"
        } else {
            // Join all tasks with newline, numbered 1, 2, 3...
            var display = ""
            for i in 0..<tasks.count {
                display += "\(i + 1). \(tasks[i])\n"
            }
            taskListLabel.text = display
        }
    }
}
