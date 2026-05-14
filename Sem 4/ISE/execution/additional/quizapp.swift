import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var questionLabel: UILabel!      // Shows the current question
    @IBOutlet weak var scoreLabel: UILabel!          // Shows current score
    @IBOutlet weak var progressLabel: UILabel!       // Shows question number (e.g., 1/5)
    @IBOutlet weak var feedbackLabel: UILabel!       // Shows "Correct!" or "Wrong!"

    // Quiz data - array of tuples (question, correctAnswer)
    let questions: [(String, Bool)] = [
        ("Swift is developed by Apple.", true),
        ("UIKit is used for Android development.", false),
        ("An IBOutlet connects UI to code.", true),
        ("Optionals can never be nil.", false),
        ("A struct is a value type in Swift.", true)
    ]

    var currentIndex: Int = 0   // Tracks which question we're on
    var score: Int = 0          // Tracks correct answers

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackLabel.text = ""
        loadQuestion()
    }

    // Display the current question
    func loadQuestion() {
        if currentIndex < questions.count {
            questionLabel.text = questions[currentIndex].0
            progressLabel.text = "Question \(currentIndex + 1) of \(questions.count)"
            scoreLabel.text = "Score: \(score)"
        } else {
            // Quiz finished
            questionLabel.text = "Quiz Over!"
            progressLabel.text = "Final Score: \(score)/\(questions.count)"
            feedbackLabel.text = ""
        }
    }

    // "True" button tapped
    @IBAction func trueTapped(_ sender: UIButton) {
        checkAnswer(userAnswer: true)
    }

    // "False" button tapped
    @IBAction func falseTapped(_ sender: UIButton) {
        checkAnswer(userAnswer: false)
    }

    // Compare user's answer with correct answer
    func checkAnswer(userAnswer: Bool) {
        // Don't do anything if quiz is over
        if currentIndex >= questions.count {
            return
        }

        let correctAnswer = questions[currentIndex].1

        if userAnswer == correctAnswer {
            score += 1
            feedbackLabel.text = "Correct!"
            feedbackLabel.textColor = UIColor.green
        } else {
            feedbackLabel.text = "Wrong!"
            feedbackLabel.textColor = UIColor.red
        }

        // Move to next question
        currentIndex += 1
        loadQuestion()
    }

    // "Restart" button tapped - reset quiz
    @IBAction func restartTapped(_ sender: UIButton) {
        currentIndex = 0
        score = 0
        feedbackLabel.text = ""
        loadQuestion()
    }
}
