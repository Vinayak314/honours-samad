import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var timeLabel: UILabel!          // Shows elapsed time
    @IBOutlet weak var lapLabel: UILabel!            // Shows recorded lap times
    @IBOutlet weak var statusLabel: UILabel!         // Shows "Running" or "Stopped"

    var timer: Timer?           // Timer object that fires every 0.1 seconds
    var elapsedTime: Double = 0.0   // Total seconds elapsed
    var isRunning: Bool = false     // Tracks if stopwatch is active
    var lapCount: Int = 0           // Number of laps recorded

    // Called once when the screen first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "00:00.0"
        statusLabel.text = "Stopped"
        lapLabel.text = ""
        lapLabel.numberOfLines = 0  // Allow multiple lines
    }

    // "Start" button tapped
    @IBAction func startTapped(_ sender: UIButton) {
        if isRunning { return }  // Don't start twice

        isRunning = true
        statusLabel.text = "Running"

        // Timer fires updateTime() every 0.1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
    }

    // Called by the timer every 0.1 seconds
    @objc func updateTime() {
        elapsedTime += 0.1
        timeLabel.text = formatTime(elapsedTime)
    }

    // "Stop" button tapped
    @IBAction func stopTapped(_ sender: UIButton) {
        timer?.invalidate()  // Stop the timer
        timer = nil
        isRunning = false
        statusLabel.text = "Stopped"
    }

    // "Lap" button tapped - record current time
    @IBAction func lapTapped(_ sender: UIButton) {
        if !isRunning { return }  // Only record laps while running

        lapCount += 1
        let lapTime = formatTime(elapsedTime)
        // Append new lap to existing text
        lapLabel.text = (lapLabel.text ?? "") + "Lap \(lapCount): \(lapTime)\n"
    }

    // "Reset" button tapped - clear everything
    @IBAction func resetTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = nil
        isRunning = false
        elapsedTime = 0.0
        lapCount = 0
        timeLabel.text = "00:00.0"
        statusLabel.text = "Stopped"
        lapLabel.text = ""
    }

    // Formats seconds into MM:SS.d format
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let tenths = Int(time * 10) % 10
        return String(format: "%02d:%02d.%d", minutes, seconds, tenths)
    }
}
