# Manual Tasks Guide: Profile Settings App

This guide explains the manual tasks required to build this app in Xcode's Interface Builder (Storyboard).

## 1. Auto Layout Constraints
Auto Layout ensures your UI adapts to different screen sizes.

**Steps:**
- **Stack Views:** Embed the profile image, text fields, and dark mode switch in a Vertical Stack View to easily arrange them. Embed the "Dark Mode" label and switch in a Horizontal Stack View.
- **Constraints on Stack View:** Pin the main vertical Stack View to the Safe Area (e.g., Top: 20, Leading: 20, Trailing: 20).
- **Constraints on Elements:** Set a fixed height constraint (e.g., 100) for the `UIImageView` and a fixed height (e.g., 40) for the `UIButton`. Pin the button to the bottom of the Stack View with a top spacing constraint.
- **Confirmation Screen:** Similarly, use a Vertical Stack View for the labels and pin it to the Top, Leading, and Trailing edges of the Safe Area.


## 3. Segue (Passing Data)
A Segue defines the transition from one View Controller to another.

**Steps:**
- **Create Segue:** Control-drag directly from the "Save Settings" button to the `ConfirmationViewController`. Select "Present Modally" as the kind. This creates a storyboard segue triggered by the button tap.
- **Identifier:** Select the segue arrow in Storyboard, go to the Attributes Inspector, and set the Identifier to `showConfirmation`.
- **Code implementation (`prepare(for:sender:)`):** When the segue is triggered, the `prepare` method is called. Inside, you check the identifier, cast `segue.destination` to your `ConfirmationViewController`, and assign the text field values to the variables in the destination.

## 4. IBOutlets (Connecting UI to Code)
IBOutlets allow you to read from or modify UI elements in your code.

**Steps:**
- Open the Storyboard and the View Controller file side-by-side (using Assistant Editor).
- Control-drag from each UI element (like `UITextField`, `UIImageView`, `UISwitch`) into the class definition in your Swift file.
- Name the outlet (e.g., `nameTextField`) and click Connect.

## 5. IBActions (Connecting User Interaction to Code)
IBActions are functions triggered when a user interacts with a UI element.

**Steps:**
- Control-drag from the interactive UI element (like `UIButton` or `UISwitch`) into your Swift file.
- Change the Connection type to "Action".
- Name the action (e.g., `saveSettingsTapped`) and select the appropriate event (e.g., `Touch Up Inside` for buttons, `Value Changed` for switches).
- Click Connect. Inside the generated function, write the desired logic.
