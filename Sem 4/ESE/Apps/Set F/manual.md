# Gallery App Manual

This manual explains the storyboard setup, auto layout constraints, UI connections, and navigation logic used in the Gallery App.

## 1. Storyboard Setup & Navigation (Segues)

The app utilizes a `UINavigationController` as the initial view controller to handle the navigation flow.

- **Initial Setup:** A Navigation Controller is set as the initial view controller. The main `ViewController` is set as its root view controller.
- **Segues:** 
  - There are three `UIButton` elements on the main screen. 
  - Each button has a **"Show" Segue** connected directly to the `SecondViewController`. This allows pushing the new screen onto the navigation stack when a button is tapped.
  - The segue logic dynamically identifies which button was tapped by accessing the `sender` parameter in the `prepare(for:sender:)` method.

## 2. Auto Layout Constraints

Auto Layout ensures the app looks correct across different screen sizes.

### Main Screen (`ViewController`)
- A **Vertical UIStackView** contains the 3 buttons.
- **Constraints on StackView:** Centered horizontally and vertically in the Safe Area. Leading and trailing anchors have a constant padding (e.g., 50 points) to give it a nice width.
- **Constraints on Buttons:** Each button has a fixed height constraint (e.g., 40 points).

### Second Screen (`SecondViewController`)
- **Title Label (`UILabel`):** Pinned to the top of the Safe Area, with leading and trailing constraints (e.g., 20 points). Fixed height constraint (e.g., 30 points).
- **Image View (`UIImageView`):** Pinned below the Title Label. Leading, trailing, and bottom constraints are tied to the Safe Area (e.g., 20 points).
- **Content Mode:** The `UIImageView` uses `Aspect Fit` to ensure the image scales correctly without distortion while fitting within the bounds.

## 3. IBOutlet & Action Connections

- **SecondViewController IBOutlets:**
  - `imageView`: Connected to the `UIImageView` on the storyboard to display the image.
  - `titleLabel`: Connected to the `UILabel` on the storyboard to display the image title.
- **Data Passing (Button Actions):** 
  - Instead of `IBAction` methods, the transition is handled by the **Show Segues** originating directly from the buttons.
  - When a button is pressed, it triggers the segue, and the `prepare(for:sender:)` method in `ViewController.swift` is called. The button itself is passed as the `sender`.
  - The `titleLabel.text` of the sender button is used to determine which image name and title should be passed to the properties (`imageTitle` and `imageName`) of `SecondViewController`.

## 4. Required Assets

Make sure to add images corresponding to the names used in the code to your `Assets.xcassets` directory:
- `nature_image`
- `city_image`
- `space_image`

If these images are not present, the `SecondViewController` will fallback to using a system photo icon (`SF Symbols`).
