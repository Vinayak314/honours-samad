// ============================================================
// Q6: Delegate Pattern and Class-Only Protocols
// ============================================================
// Implement a download manager using the delegate pattern:
//   1. Define a class-only protocol `DownloadDelegate: AnyObject` with methods:
//       - func downloadDidStart(fileName: String)
//       - func downloadDidProgress(fileName: String, percent: Int)
//       - func downloadDidFinish(fileName: String, data: String)
//       - func downloadDidFail(fileName: String, error: String)
//   2. Create a class `DownloadManager` that:
//       - Has a weak `delegate` property of type DownloadDelegate?
//       - Has a method `download(fileName: String)` that simulates a download
//         by calling delegate methods in sequence (start → progress at 25, 50, 75, 100 → finish).
//       - If the filename contains "error", the download should fail.
//   3. Create a class `FileViewController` conforming to `DownloadDelegate`
//      that prints log messages for each delegate callback.
//   4. Demonstrate by downloading two files: one success, one failure.
// ============================================================

protocol DownloadDelegate: AnyObject {
    func downloadDidStart(fileName: String)
    func downloadDidProgress(fileName: String, percent: Int)
    func downloadDidFinish(fileName: String, data: String)
    func downloadDidFail(fileName: String, error: String)
}

class DownloadManager {
    weak var delegate: DownloadDelegate?
    
    func download(fileName: String) {
        delegate?.downloadDidStart(fileName: fileName)
        if fileName.contains("error") {
            delegate?.downloadDidFail(fileName: fileName, error: "Failed")
            return
        }
        for p in [25, 50, 75, 100] { delegate?.downloadDidProgress(fileName: fileName, percent: p) }
        delegate?.downloadDidFinish(fileName: fileName, data: "Done")
    }
}

class FileViewController: DownloadDelegate {
    func downloadDidStart(fileName: String) { print("Start", fileName) }
    func downloadDidProgress(fileName: String, percent: Int) { print("\(percent)%") }
    func downloadDidFinish(fileName: String, data: String) { print("Finish", data) }
    func downloadDidFail(fileName: String, error: String) { print("Error", error) }
}

let vc = FileViewController()
let dl = DownloadManager()
dl.delegate = vc
dl.download(fileName: "test.txt")
dl.download(fileName: "error.txt")

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Delegate Pattern: `DownloadManager` delegates explicit UX notifications back strictly to whatever is declared as the `delegate`, rather than writing rigid View Controller logic into the model itself.
- Class-Only Protocols (`AnyObject`): Ensures that only reference-typed classes adapt the protocol, allowing us to safely mark the delegate as `weak`.
- Weak References: Prevents strong reference cycles (Memory Leaks), allowing appropriate release by the ARC object-deallocation process.
*/
