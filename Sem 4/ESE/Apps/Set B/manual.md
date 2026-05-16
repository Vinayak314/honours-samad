# iOS App Development - Manual Tasks Explained

Here is a short explanation of the manual tasks performed to build the Login app:

### 0. Creating and Linking a Custom View Controller File
To separate code efficiently, we moved the `DetailsViewController` out of `ViewController.swift` and into its own file:
1. **Create the File**: Go to `File > New > File...` (or hit `Cmd+N`).
2. **Choose Template**: Select **Cocoa Touch Class** under the iOS tab and click Next.
3. **Configure**: Name it `DetailsViewController` and ensure it is a "Subclass of: `UIViewController`". Keep language as Swift.
4. **Save**: Save it inside the project directory (`setb`).
5. **Link to Storyboard**: Open `Main.storyboard`, select the second View Controller. In the **Identity Inspector** (the ID card icon on the right panel), set the **Class** field to `DetailsViewController`. This links the storyboard screen to your newly created file!

### 1. UI Layout & Auto Layout Constraints
- **Stack Views**: A vertical `UIStackView` groups the username, password, buttons, and toggle switch. Using stack views drastically reduces the number of constraints needed.
- **Centering & Margins**: The main `UIStackView` is vertically centered (`centerY`) and horizontally padded (20 points `leading` and `trailing` to the Safe Area). This ensures the UI scales correctly and remains readable across all iPhone sizes.
- **Details Screen**: The `UILabel` on the second screen is similarly constrained (`centerY`, `leading`, and `trailing`) so the welcome message stays perfectly centered.

### 2. Connections (IBOutlets)
- UI elements (TextFields, Switch, Label) are linked to the Swift code via `@IBOutlet` to read user input and update values.

### 3. Actions (IBActions)
- **Login Button**: Linked to validate input and trigger the segue.
- **Reset Button**: Clears both text fields.
- **Dark Mode Switch**: Toggles the interface style between `.light` and `.dark`.

### 4. Navigation & Segues

Our app uses **Storyboards** and **Segues** to handle moving between screens. Here is how the flow works step-by-step:

- **Navigation Controller**: The initial `ViewController` is embedded in a `UINavigationController` (Editor > Embed In > Navigation Controller). This automatically provides the top navigation bar with a back button and handles the standard "push/pop" transition between screens.
- **Segue Setup (The "Bridge")**: In `Main.storyboard`, a "Show" segue (an arrow) is drawn from the first View Controller to the second. 
  - *Crucial Step*: We give this segue a unique Identifier named `showDetails` in the Attributes Inspector so we can refer to it in our code.
- **Triggering the Segue**: We purposefully do NOT connect the Login button directly to the next screen. If we did, the app would navigate even if the text fields were empty! Instead, the button runs our `loginButtonTapped` code. 
  - If the validation passes (username is not empty), we tell the app to navigate manually by calling `performSegue(withIdentifier: "showDetails", sender: self)`.
- **Passing Data (`prepare` method)**: Right after `performSegue` is called—but *before* the new screen actually appears—iOS automatically triggers the `prepare(for:sender:)` method. We use this as an "interceptor" to hand off our data:
  1. **Check the Identifier**: We verify we are running the `showDetails` segue (vital if a screen has multiple exits).
  2. **Get the Destination**: We grab a reference to the upcoming screen (`segue.destination`) and cast it as our specific `DetailsViewController`.
  3. **Inject the Data**: We copy the text from the `usernameTextField` and assign it to the `username` variable waiting on the destination screen. Then, the new screen loads with the data!
