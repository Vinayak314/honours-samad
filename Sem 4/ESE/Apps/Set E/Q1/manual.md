# Manual UI Configuration Guide

This guide explains how the UI components, Auto Layout constraints, outlets, and segues were configured in `Main.storyboard` to build the Calculator app. **Note: All these connections have already been made for you in the provided `Main.storyboard` file.**

## 1. View Controllers & UI Elements
Two View Controllers were created:
1. **ViewController (Calculator Screen):**
   - **Title Label:** Displays "Simple Calculator".
   - **Text Fields:** Two `UITextField` elements (for `num1` and `num2`) with `keyboardType` set to `Decimal Pad`.
   - **Segmented Control:** A `UISegmentedControl` to select the operation (+, -, *, /).
   - **Calculate Button:** A `UIButton` to trigger the calculation.
   - *Layout:* All elements are grouped inside a vertical `UIStackView` with spacing of 20 to ensure clean alignment.

2. **ResultViewController (Result Screen):**
   - **Result Label:** A `UILabel` to display the computed result or "Division by zero" error.
   - **Close Button:** A `UIButton` to dismiss the modal view.
   - *Layout:* Grouped inside a vertical `UIStackView`.

## 2. Auto Layout Constraints
- **Calculator Screen StackView:** 
  - `Top` aligned to Safe Area Top + 100.
  - `Leading` and `Trailing` aligned to Safe Area with a constant of 40 (adds padding).
- **Result Screen StackView:**
  - `Center Y` aligned vertically in the superview.
  - `Leading` and `Trailing` aligned to Safe Area with a constant of 40.
- Using Stack Views simplified the layout process, as internal constraints between text fields and buttons are automatically managed by the stack view's vertical distribution.

## 3. IBOutlets (UI to Code Connections)
- `num1Field` connected to the first `UITextField`.
- `num2Field` connected to the second `UITextField`.
- `operationControl` connected to the `UISegmentedControl`.
- `resultLabel` (in `ResultViewController`) connected to the corresponding `UILabel`.

## 4. IBActions (Interactions)
- **Calculate Button:** Connected to `calculateTapped(_:)` in `ViewController`. It reads inputs, determines the selected operation, calculates the result, and triggers the segue.
- **Close Button:** Connected to `closeTapped(_:)` in `ResultViewController`. It calls `dismiss(animated: true, completion: nil)` to return to the calculator.

## 5. Navigation & Segue
- **Modal Presentation Segue:** A segue was drawn from `ViewController` to `ResultViewController` by Control-dragging between the View Controllers.
- **Identifier:** The segue's identifier was set to `"showResult"`.
- **Kind:** The segue type was set to `Present Modally` (which handles the requested "modal presentation segue").
- **Data Passing (`prepare(for:sender:)`):** When `performSegue` is called, `prepare(for:sender:)` is triggered. The calculated `result` and `divisionByZeroError` flag are passed to the `ResultViewController` before it appears on the screen.
