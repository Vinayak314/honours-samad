# Feedback Form iOS App Manual

This manual explains the connections and UI logic used to build the Feedback Form app. All code and storyboard edits have already been generated for you, so building the app should work directly!

## 1. Storyboard Connections (IBOutlets & IBActions)

### Main View Controller (Feedback Form)
- **`nameTextField`**: Connected to the "Name" `UITextField`.
- **`commentsTextView`**: Connected to the "Comments" `UITextView`.
- **`ratingSlider`**: Connected to the `UISlider`.
- **`ratingValueLabel`**: Connected to the `UILabel` that displays the "Selected Rating: x".
- **`sliderValueChanged(_:)`**: This IBAction is connected to the `UISlider`'s "Value Changed" event. It captures the slider's value, rounds it to the nearest integer, and updates `ratingValueLabel`.

### Result View Controller (Feedback Summary)
- **`resultLabel`**: Connected to the `UILabel` that displays the multi-line summarized feedback.

## 2. Auto Layout Constraints
The user interface has been designed to be responsive on all screen sizes using a `UIStackView`.
- **Vertical StackView**: All the form elements are embedded inside a Vertical Stack View (`axis = vertical`, `spacing = 20`).
- **Constraints**: 
  - Top = Safe Area Top + 20
  - Leading = Safe Area Leading + 20
  - Trailing = Safe Area Trailing + 20
- **TextView Height**: A fixed height constraint of `100` was added directly to the `UITextView` so it doesn't collapse inside the Stack View.

## 3. Navigation and Segues
- **Navigation Controller**: The app now uses a `UINavigationController` as the initial view controller to enable a navigation stack.
- **Push Segue**: A push (Show) segue is used. When the user taps the **Submit** button, a "Show" segue (identifier: `showResult`) is triggered to push the `ResultViewController` onto the navigation stack.
- **Data Passing (`prepare(for:sender:)`)**: 
  - Inside the main `ViewController`, the `prepare(for:sender:)` method checks for the `showResult` segue identifier.
  - It then typecasts `segue.destination` to `ResultViewController`.
  - The `name`, `rating` (cast to `Int`), and `comments` properties are set on the destination controller before the view transition completes.

## Quick Note
The `ResultViewController` implementation has been placed inside `ViewController.swift` to ensure seamless compilation without needing to manually add new files to the `.pbxproj` in Xcode. You can open the project and run it immediately!
