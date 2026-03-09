import os
import subprocess

def run_cmd(cmd):
    subprocess.run(cmd, shell=True, check=True)

def read_file(path):
    with open(path, 'r') as f:
        return f.read()

def write_file(path, content):
    with open(path, 'w') as f:
        f.write(content)

def commit_change(msg):
    run_cmd("git add -A")
    run_cmd(f'git commit -m "{msg}"')

# Base dir is existing PWD which is Lab1_Lakshay_Dhawan
# If files are in Lab1_Lakshay_Dhawan inner dir, ensure we are targeting the right ones
# We are already in Lab1_Lakshay_Dhawan for this python script execution.

# Commit 1
gvm = "GameViewModel.swift"
c = read_file(gvm)
c = c.replace("@Published var currentNumber: Int = 1", "// MARK: - Properties\n    @Published var currentNumber: Int = 1")
write_file(gvm, c)
commit_change("Add section markers for properties")

# Commit 2
c = read_file(gvm)
c = c.replace("@Published var currentNumber: Int = 1", "@Published var currentNumber: Int = 1 // Default start value")
write_file(gvm, c)
commit_change("Add comment for currentNumber")

# Commit 3
c = read_file(gvm)
c = c.replace("private var timerCurrentSubscription: AnyCancellable?", "private var timerCurrentSubscription: AnyCancellable? // Timer for the 5-second countdown")
write_file(gvm, c)
commit_change("Document timer subscription")

# Commit 4
c = read_file(gvm)
c = c.replace("func startNewRound() {\n        if", "/// Starts a new round of the game \n    func startNewRound() {\n        if")
write_file(gvm, c)
commit_change("Add docstring to startNewRound")

# Commit 5
c = read_file(gvm)
c = c.replace("    func generateRandomNumber() {", "    // MARK: - Game Logic\n    \n    func generateRandomNumber() {")
write_file(gvm, c)
commit_change("Add section marker for game logic")

# Commit 6
cv = "ContentView.swift"
c = read_file(cv)
c = c.replace("@StateObject private var viewModel = GameViewModel()", "// MARK: - Properties\n    @StateObject private var viewModel = GameViewModel()")
write_file(cv, c)
commit_change("Organize ContentView properties")

# Commit 7
c = read_file(cv)
c = c.replace("var body: some View {", "// MARK: - Body\n    var body: some View {")
write_file(cv, c)
commit_change("Organize ContentView body structure")

# Commit 8
c = read_file(cv)
c = c.replace("VStack(spacing: 40)", "VStack(spacing: 45)")
write_file(cv, c)
commit_change("Increase main spacing for better readability")

# Commit 9
c = read_file(cv)
c = c.replace(".background(Color.blue)\n                            .cornerRadius(15)", ".background(Color.blue)\n                            .cornerRadius(15)\n                            .shadow(radius: 2)")
write_file(cv, c)
commit_change("Add subtle shadow to Prime button")

# Commit 10
c = read_file(cv)
c = c.replace(".background(Color.purple)\n                            .cornerRadius(15)", ".background(Color.purple)\n                            .cornerRadius(15)\n                            .shadow(radius: 2)")
write_file(cv, c)
commit_change("Add subtle shadow to Not Prime button")


# Commit 11
c = read_file(cv)
c = c.replace(".font(.largeTitle)\n                    .fontWeight(.bold)", ".font(.system(.largeTitle, design: .rounded))\n                    .fontWeight(.heavy)")
write_file(cv, c)
commit_change("Update title font design to rounded and heavy")

# Commit 12
c = read_file(cv)
c = c.replace(".padding(.top, 40)", ".padding(.top, 50)")
write_file(cv, c)
commit_change("Adjust top padding for game title")

# Commit 13
c = read_file(cv)
c = c.replace(".shadow(radius: 2)", ".shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)")
write_file(cv, c)
commit_change("Improve button shadows for depth")

# Commit 14
c = read_file(gvm)
c = c.replace("let actuallyPrime =", "let isActuallyPrime =").replace("isPrimeSelected == actuallyPrime", "isPrimeSelected == isActuallyPrime")
write_file(gvm, c)
commit_change("Rename actuallyPrime to isActuallyPrime for better semantics")

# Commit 15
c = read_file(gvm)
c = c.replace("var i = 2", "var divisor = 2").replace("while i * i <=", "while divisor * divisor <=").replace("number % i ==", "number % divisor ==").replace("i += 1", "divisor += 1")
write_file(gvm, c)
commit_change("Refactor loop variable name in prime check")

# Commit 16
c = read_file(gvm)
c = c.replace("if attempts >= 10 {", "let maxAttempts = 10\n        if attempts >= maxAttempts {")
write_file(gvm, c)
commit_change("Extract magic number for max attempts")

# Commit 17
c = read_file(gvm)
c = c.replace("func resetGame() {", "// MARK: - Reset State\n    \n    func resetGame() {")
write_file(gvm, c)
commit_change("Add section marker for reset state")

# README changes
rm = "README.md"

# Commit 18
c = read_file(rm)
c += "\n## Features\n- 5-second countdown timer\n- Prime checking logic\n- Visual feedback for answers\n"
write_file(rm, c)
commit_change("Add Features section to README")

# Commit 19
c = read_file(rm)
c += "\n## Requirements\n- iOS 15.0+\n- Xcode 14.0+\n- Swift 5.0+\n"
write_file(rm, c)
commit_change("Add Requirements section to README")

# Commit 20
c = read_file(rm)
c += "\n## Author\nLakshay Dhawan\n"
write_file(rm, c)
commit_change("Update README with Author info")

print("Created 20 commits successfully!")
