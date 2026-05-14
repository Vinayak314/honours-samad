# Manual Storyboard Setup Instructions

## 1. Main Navigation Setup
- **Navigation Controller:** Open `Main.storyboard`, select the initial View Controller (Screen 1), and go to **Editor > Embed In > Navigation Controller**. 
  - *Why?* A Navigation Controller manages a stack of view controllers and provides a navigation bar at the top. It is strictly required to enable "Push" (Show) segues, allowing seamless horizontal transitions and automatic back-button functionality between screens.
- In the Identity Inspector, ensure the Custom Class for Screen 1 is set to `ViewController`.

## 2. Screen 1 (MenuViewController) Layout & Auto Layout
- **Auto Layout Constraints:**
  - Add a **Vertical Stack View** to the View Controller to hold your UI components. 
  - To ensure the app scales correctly across different iPhone sizes, apply Auto Layout constraints by pinning the Stack View to the **Safe Area** (e.g., Top: 24, Leading: 20, Trailing: 20).
- Inside this Vertical Stack View, add three **Horizontal Stack Views** (one for each food item). Set their distribution to "Fill" and spacing to 10.
- For each Horizontal Stack View, add a `UILabel` (for the item name) and a `UISwitch` (for selection).
- Below the stack views, add a `UIButton` and set its title to "Next".
- **Assets:** If you wish to incorporate icons or custom background images, drag and drop those resources into the `Assets.xcassets` folder in Xcode, and reference them using `UIImageView` in the Storyboard.
- Open the Assistant Editor and connect the following IBOutlets to `ViewController.swift`:
  - `item1Label`, `item1Switch`
  - `item2Label`, `item2Switch`
  - `item3Label`, `item3Switch`

## 3. Screen 2 (SummaryViewController) Setup & Segue 
- **Adding the Screen:** Drag a new **View Controller** from the Object Library to the Storyboard. In the Identity Inspector, set its Custom Class to `SummaryViewController`.
- **Configuring the Navigation Segue:** 
  - Control-drag from the "Next" UIButton on Screen 1 to the new View Controller (Screen 2).
  - Select **"Show" (Push)** from the action menu. Because the initial screen is embedded in a Navigation Controller, this creates a push transition, sliding the new screen over from the right.
  - Select the segue line (the arrow between the screens), open the Attributes Inspector, and set the **Identifier** to `showSummary`. 
  - *Why?* The exact identifier `showSummary` is used in the `prepare(for:sender:)` method within `ViewController.swift`. This triggers right before the segue occurs, acting as the mechanism to pass the selected food items and the calculated total data securely to the `SummaryViewController`.

## 4. Screen 2 Layout & Auto Layout
- Add a `UILabel` to display the summary. Connect it to the `summaryLabel` IBOutlet. Set its "Lines" property to `0` so it can wrap text dynamically depending on the number of items ordered.
- Add a `UITextField` to display the total. In its Attributes Inspector, uncheck "User Interaction Enabled" to make it read-only.
- Connect the text field to the `totalTextField` IBOutlet.
- **Auto Layout Constraints:**
  - Embed the `UILabel` and `UITextField` into a new Vertical Stack View. 
  - Apply Auto Layout constraints to pin the Stack View to the Safe Area (e.g., Top: 24, Leading: 20, Trailing: 20). Using a Stack View combined with Safe Area constraints is the best way to handle layout differences across varying screen dimensions.
