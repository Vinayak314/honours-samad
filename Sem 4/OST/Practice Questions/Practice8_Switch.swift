// Problem Statement 8: Switch Statement (Control Flow)
// Simulate an ATM machine menu using a switch statement.

let menuChoice: Int = 2

print("ATM Menu:")
print("1 - Check Balance\n2 - Withdraw Cash\n3 - Deposit Cash\n4 - Exit")

switch menuChoice {
case 1:
    print("\nAction: Retrieving account balance...")
case 2:
    print("\nAction: Please enter the amount you wish to withdraw.")
case 3:
    print("\nAction: Insert cash to deposit into the machine drawer.")
case 4:
    print("\nAction: Thank you. Returning your card...")
default:
    print("\nAction: Invalid menu option. Please try again.")
}
