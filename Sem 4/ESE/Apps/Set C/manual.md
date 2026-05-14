# Storyboard Connections Manual

This manual explains how the Storyboard was set up for the Newsletter Registration app, specifically focusing on Auto Layout, connections, and navigation.

## 1. Auto Layout Constraints

The entire form layout relies heavily on **UIStackView** to make constraints simpler and more responsive.

*   **Main Vertical Stack View**: Contains all text fields, horizontal stack views (for switches), and the submit button.
    *   **Constraints**: Pinned `20` points from the Top, Leading, and Trailing edges of the Safe Area.
    *   **Spacing**: Set to `20` between elements to provide breathing room.
*   **Horizontal Stack Views**: The Gender and Subscription rows use inner horizontal stack views. These distribute space naturally without needing manual dimension constraints.
*   **Submit Button Height**: The button has a fixed height constraint of `44` points so it's easily tappable.

## 2. Navigation Controller Setup

To allow a push transition (sliding left-to-right) between screens, a `UINavigationController` is required.
*   The Navigation Controller is set as the **Initial View Controller** in the Storyboard attributes.
*   It has a `rootViewController` relationship segue pointing to the `ViewController` (Registration Screen).
*   This automatically adds a navigation bar at the top of the Registration and Details screens.

## 3. IBOutlets & IBActions Connections

**IBOutlets** (UI to Code):
*   `nameTextField` -> Full Name input field.
*   `genderSwitch` -> Gender toggle.
*   `emailTextField` -> Email input field.
*   `ageSlider` -> Slider for age selection.
*   `ageLabel` -> Label displaying the current age value.
*   `subscriptionSwitch` -> Newsletter subscription toggle.
*   `detailsLabel` -> Multi-line label in `DetailsViewController` to show final results.

**IBActions** (Code to UI Events):
*   `ageSliderChanged(_:)` -> Connected to the `ageSlider` with the **Value Changed** event. This triggers whenever the user drags the slider, instantly updating `ageLabel.text`.

## 4. Segue and Navigation Logic

The transition from the form to the summary screen is handled by a **Show (Push) Segue**.

*   **Connection**: A segue is drawn directly from the "Submit" `UIButton` in `ViewController` to the `DetailsViewController`.
*   **Identifier**: The segue is given the identifier `"showDetails"`.
*   **Data Passing (`prepare(for:sender:)`)**: 
    When the button is tapped, the segue initiates. Before the transition completes, the `prepare(for:sender:)` method in `ViewController.swift` is automatically called. 
    Inside this method, we:
    1. Check if `segue.identifier == "showDetails"`.
    2. Cast `segue.destination` to `DetailsViewController`.
    3. Read the inputs from all UI controls (text fields, switches, sliders).
    4. Construct a formatted multi-line string.
    5. Assign the string to the `detailsText` property of the `DetailsViewController`.

Once the `DetailsViewController` loads, its `viewDidLoad()` method takes `detailsText` and sets it to the `detailsLabel.text`.
