Q1. What is the purpose of the throws keyword in Swift functions? Provide a throwing function.

In Swift, the **`throws` keyword is used to indicate that a function can produce or throw an error**. By marking a function with `throws`, you allow it to propagate any errors it encounters up to the caller, rather than forcing the function to handle the error internally. 

Inside the throwing function, you use the **`throw`** statement to trigger a specific error (typically defined by an enumeration that conforms to the `Error` protocol) when a specific failure condition is met. 

Here is an example of a throwing function that throws an error if a user attempts to divide by zero:

```swift
// 1. Create an enum representing the error
enum DivisionError: Error {
    case dividedByZero
}

// 2. Create the throwing function using the 'throws' keyword
func division(numerator: Int, denominator: Int) throws {
    // 3. Use the 'throw' statement to trigger the error if the condition is met
    if denominator == 0 {
        throw DivisionError.dividedByZero
    }
    
    // ... continue with the division logic if no error is thrown
}
```

Whenever you call a function that has been marked with `throws`, you must acknowledge that it can fail by using the `try` keyword (e.g., `try division(numerator: 10, denominator: 0)`). As discussed previously, you will typically wrap this call in a `do-catch` block to gracefully handle the error if it is thrown.