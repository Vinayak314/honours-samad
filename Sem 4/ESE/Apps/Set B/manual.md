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
- **Navigation Controller**: The initial `ViewController` is embedded in a `UINavigationController` (via Editor > Embed In > Navigation Controller). This provides a top navigation bar and standard push/pop navigation functionality.
- **Segue Setup**: A "Show" (push) segue is drawn directly between the Login View Controller and the Details View Controller. Its identifier is set to `showDetails` in the Attributes Inspector.
- **Triggering Segues Programmatically**: Instead of connecting the segue directly to the Login button, it's triggered via `performSegue(withIdentifier: "showDetails", sender: self)` only *after* the credentials have been validated.
- **Passing Data**: The `prepare(for:sender:)` method is overridden to intercept the segue before it occurs. We check if the identifier is `showDetails`, cast the destination to `DetailsViewController`, and safely pass the `username` to the next screen.
