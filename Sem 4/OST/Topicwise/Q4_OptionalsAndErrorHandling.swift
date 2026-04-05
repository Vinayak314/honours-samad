// ============================================================
// Q4: Optionals, Switch, Conditionals, Error Handling, and Loops
// ============================================================
// Build a simple bank account system:
//   1. Define an enum `BankError: Error` with cases:
//       - insufficientFunds(shortBy: Double)
//       - invalidAmount
//       - accountNotFound
//   2. Create a struct `BankAccount` with:
//       - Properties: accountNumber (String), holderName (String), balance (Double)
//       - A mutating method `deposit(_ amount: Double) throws` 
//         (throws invalidAmount if amount <= 0)
//       - A mutating method `withdraw(_ amount: Double) throws`
//         (throws invalidAmount if amount <= 0, insufficientFunds if balance < amount)
//   3. Create a class `Bank` with:
//       - A dictionary of [String: BankAccount] (accountNumber → account)
//       - A method `findAccount(_ number: String) -> BankAccount?`
//       - A method `transfer(from: String, to: String, amount: Double) throws`
//   4. Demonstrate using do-catch, optional binding (if let / guard let),
//      and a switch on the error cases.
// ============================================================

enum BankError: Error {
    case insufficientFunds(shortBy: Double), invalidAmount, accountNotFound
}

struct BankAccount {
    var accountNumber: String
    var holderName: String
    var balance: Double
    
    mutating func deposit(_ amount: Double) throws {
        guard amount > 0 else { throw BankError.invalidAmount }
        balance += amount
    }
    mutating func withdraw(_ amount: Double) throws {
        guard amount > 0 else { throw BankError.invalidAmount }
        if balance < amount { throw BankError.insufficientFunds(shortBy: amount - balance) }
        balance -= amount
    }
}

class Bank {
    var accounts: [String: BankAccount] = [:]
    
    func findAccount(_ number: String) -> BankAccount? { accounts[number] }
    
    func transfer(from srcId: String, to dstId: String, amount: Double) throws {
        guard var src = accounts[srcId], var dst = accounts[dstId] else { throw BankError.accountNotFound }
        try src.withdraw(amount)
        try dst.deposit(amount)
        accounts[srcId] = src
        accounts[dstId] = dst
    }
}

let bank = Bank()
bank.accounts["1"] = BankAccount(accountNumber: "1", holderName: "Alice", balance: 100)
bank.accounts["2"] = BankAccount(accountNumber: "2", holderName: "Bob", balance: 50)

do {
    try bank.transfer(from: "1", to: "2", amount: 200)
} catch let err as BankError {
    switch err {
    case .insufficientFunds(let s): print("Short by \(s)")
    case .invalidAmount: print("Invalid amount")
    case .accountNotFound: print("Account not found")
    }
} catch { print(error) }

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Custom Errors: We conform a custom enum to the native `Error` protocol natively representing failure states.
- Error Handling (`throws`, `do-catch`): `throws` marks that a function can fail. `try` executes it, and the `catch` block safely traps errors instead of letting the application crash.
- Optionals & Binding: Securely handling properties that might legitimately contain `nil` (missing values).
*/
