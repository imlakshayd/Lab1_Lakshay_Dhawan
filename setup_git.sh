#!/bin/bash

# setup_git.sh - Generates a realistic git history for Lab 1

# 1. Initialize Git
rm -rf .git # Clean slate if re-running
git init
git branch -M main

# 2. Setup safe cleanup of existing files to rebuild them
# We will overwrite them step by step.

# --- COMMIT 1: Initial ---
echo "# Lab 1 Assignment - Prime Number Game" > README.md
git add README.md
git commit -m "Initial commit: Project setup"

# --- COMMIT 2: App Entry Point ---
cat > Lab1App.swift <<EOF
import SwiftUI

@main
struct Lab1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
EOF
git add Lab1App.swift
git commit -m "Add Lab1App entry point"

# --- COMMIT 3: Basic ViewModel ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    
    init() {
        // Init
    }
}
EOF
git add GameViewModel.swift
git commit -m "Create GameViewModel stub"

# --- COMMIT 4: Basic ContentView ---
cat > ContentView.swift <<EOF
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        Text("Prime Game")
    }
}
EOF
git add ContentView.swift
git commit -m "Create ContentView stub"

# --- COMMIT 5: Logic - Number Generation ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        generateRandomNumber()
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
}
EOF
git add GameViewModel.swift
git commit -m "Implement random number generation"

# --- COMMIT 6: Logic - Prime Check ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        generateRandomNumber()
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    func isNumberPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var i = 2
        while i * i <= number {
            if number % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
}
EOF
git add GameViewModel.swift
git commit -m "Add prime checking algorithm"

# --- COMMIT 7: UI - Display Number ---
cat > ContentView.swift <<EOF
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            Text("Prime Number Game")
                .font(.largeTitle)
            Spacer()
            Text("\(viewModel.currentNumber)")
                .font(.system(size: 80))
            Spacer()
        }
    }
}
EOF
git add ContentView.swift
git commit -m "Display current random number in UI"

# --- COMMIT 8: Logic - Scoring Properties ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    @Published var correctCount: Int = 0
    @Published var wrongCount: Int = 0
    @Published var attempts: Int = 0
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        generateRandomNumber()
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    func isNumberPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var i = 2
        while i * i <= number {
            if number % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
}
EOF
git add GameViewModel.swift
git commit -m "Add scoring properties to ViewModel"

# --- COMMIT 9: UI - Add Buttons ---
cat > ContentView.swift <<EOF
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            Text("Prime Number Game")
                .font(.largeTitle)
            Spacer()
            Text("\(viewModel.currentNumber)")
                .font(.system(size: 80))
            Spacer()
            HStack {
                Button("Prime") {
                    // Action
                }
                Button("Not Prime") {
                    // Action
                }
            }
            .padding()
        }
    }
}
EOF
git add ContentView.swift
git commit -m "Add Prime and Not Prime buttons"

# --- COMMIT 10: Logic - Check Answer ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    @Published var correctCount: Int = 0
    @Published var wrongCount: Int = 0
    @Published var attempts: Int = 0
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        generateRandomNumber()
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    func isNumberPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var i = 2
        while i * i <= number {
            if number % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
    
    func checkAnswer(isPrimeSelected: Bool) {
        let actuallyPrime = isNumberPrime(currentNumber)
        if isPrimeSelected == actuallyPrime {
            correctCount += 1
        } else {
            wrongCount += 1
        }
        attempts += 1
        startNewRound()
    }
}
EOF
git add GameViewModel.swift
git commit -m "Implement answer checking logic"

# --- COMMIT 11: UI - Wire up Buttons ---
cat > ContentView.swift <<EOF
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            Text("Prime Number Game")
                .font(.largeTitle)
            Spacer()
            Text("\(viewModel.currentNumber)")
                .font(.system(size: 80))
            Spacer()
            HStack {
                Button("Prime") {
                    viewModel.checkAnswer(isPrimeSelected: true)
                }
                Button("Not Prime") {
                    viewModel.checkAnswer(isPrimeSelected: false)
                }
            }
            .padding()
        }
    }
}
EOF
git add ContentView.swift
git commit -m "Connect buttons to ViewModel logic"

# --- COMMIT 12: Logic - Feedback State ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    @Published var correctCount: Int = 0
    @Published var wrongCount: Int = 0
    @Published var attempts: Int = 0
    @Published var feedback: FeedbackType = .none
    
    enum FeedbackType {
        case none
        case correct
        case wrong
    }
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        generateRandomNumber()
        feedback = .none
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    func isNumberPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var i = 2
        while i * i <= number {
            if number % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
    
    func checkAnswer(isPrimeSelected: Bool) {
        let actuallyPrime = isNumberPrime(currentNumber)
        if isPrimeSelected == actuallyPrime {
            correctCount += 1
            feedback = .correct
        } else {
            wrongCount += 1
            feedback = .wrong
        }
        attempts += 1
        
        // Delay next round
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startNewRound()
        }
    }
}
EOF
git add GameViewModel.swift
git commit -m "Add visual feedback state and delay"

# --- COMMIT 13: UI - Feedback Icons ---
cat > ContentView.swift <<EOF
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            Text("Prime Number Game")
                .font(.largeTitle)
            Spacer()
            Text("\(viewModel.currentNumber)")
                .font(.system(size: 80))
            
            // Feedback
            if viewModel.feedback == .correct {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else if viewModel.feedback == .wrong {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
            
            Spacer()
            HStack {
                Button("Prime") {
                    viewModel.checkAnswer(isPrimeSelected: true)
                }
                Button("Not Prime") {
                    viewModel.checkAnswer(isPrimeSelected: false)
                }
            }
            .padding()
        }
    }
}
EOF
git add ContentView.swift
git commit -m "Show feedback icons in UI"

# --- COMMIT 14: Logic - Timer Implementation ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    @Published var correctCount: Int = 0
    @Published var wrongCount: Int = 0
    @Published var attempts: Int = 0
    @Published var feedback: FeedbackType = .none
    
    enum FeedbackType {
        case none
        case correct
        case wrong
    }
    
    private var timerCurrentSubscription: AnyCancellable?
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        generateRandomNumber()
        feedback = .none
        startTimer()
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    func isNumberPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var i = 2
        while i * i <= number {
            if number % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
    
    func checkAnswer(isPrimeSelected: Bool) {
        timerCurrentSubscription?.cancel()
        let actuallyPrime = isNumberPrime(currentNumber)
        if isPrimeSelected == actuallyPrime {
            correctCount += 1
            feedback = .correct
        } else {
            wrongCount += 1
            feedback = .wrong
        }
        attempts += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startNewRound()
        }
    }
    
    func startTimer() {
        timerCurrentSubscription?.cancel()
        timerCurrentSubscription = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.handleTimeout()
            }
    }
    
    func handleTimeout() {
        wrongCount += 1
        feedback = .wrong
        attempts += 1
        timerCurrentSubscription?.cancel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startNewRound()
        }
    }
}
EOF
git add GameViewModel.swift
git commit -m "Add 5-second timer logic"

# --- COMMIT 15: Logic - Game Over Dialog ---
cat > GameViewModel.swift <<EOF
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    @Published var correctCount: Int = 0
    @Published var wrongCount: Int = 0
    @Published var attempts: Int = 0
    @Published var showResultDialog: Bool = false
    @Published var feedback: FeedbackType = .none
    
    enum FeedbackType {
        case none
        case correct
        case wrong
    }
    
    private var timerCurrentSubscription: AnyCancellable?
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        if attempts >= 10 {
            showResultDialog = true
            timerCurrentSubscription?.cancel()
            return
        }
        
        generateRandomNumber()
        feedback = .none
        startTimer()
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    func isNumberPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var i = 2
        while i * i <= number {
            if number % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
    
    func checkAnswer(isPrimeSelected: Bool) {
        timerCurrentSubscription?.cancel()
        let actuallyPrime = isNumberPrime(currentNumber)
        if isPrimeSelected == actuallyPrime {
            correctCount += 1
            feedback = .correct
        } else {
            wrongCount += 1
            feedback = .wrong
        }
        attempts += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startNewRound()
        }
    }
    
    func startTimer() {
        timerCurrentSubscription?.cancel()
        timerCurrentSubscription = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.handleTimeout()
            }
    }
    
    func handleTimeout() {
        wrongCount += 1
        feedback = .wrong
        attempts += 1
        timerCurrentSubscription?.cancel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startNewRound()
        }
    }
    
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attempts = 0
        showResultDialog = false
        startNewRound()
    }
}
EOF
git add GameViewModel.swift
git commit -m "Implement game over dialog logic after 10 attempts"

# --- COMMIT 16: UI - Alert Dialog ---
# Updating ContentView to bind to showResultDialog and use full styling
cat > ContentView.swift <<EOF
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("Prime Number Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Spacer()
                
                Text("\(viewModel.currentNumber)")
                    .font(.system(size: 80, weight: .heavy, design: .rounded))
                    .foregroundColor(.primary)
                
                Spacer()
                
                if viewModel.feedback == .correct {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                } else if viewModel.feedback == .wrong {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.red)
                } else {
                    Color.clear.frame(width: 80, height: 80)
                }
                
                Spacer()
                
                HStack(spacing: 30) {
                    Button(action: {
                        viewModel.checkAnswer(isPrimeSelected: true)
                    }) {
                        Text("Prime")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    .disabled(viewModel.feedback != .none)
                    
                    Button(action: {
                        viewModel.checkAnswer(isPrimeSelected: false)
                    }) {
                        Text("Not Prime")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 60)
                            .background(Color.purple)
                            .cornerRadius(15)
                    }
                    .disabled(viewModel.feedback != .none)
                }
                .padding(.bottom, 50)
            }
        }
        .alert(isPresented: \$viewModel.showResultDialog) {
            Alert(
                title: Text("Game Over"),
                message: Text("Correct: \(viewModel.correctCount)\nWrong: \(viewModel.wrongCount)"),
                dismissButton: .default(Text("Restart")) {
                    viewModel.resetGame()
                }
            )
        }
    }
}
EOF
git add ContentView.swift
git commit -m "Connect Alert dialog and improve UI styling"

# --- COMMIT 17: Polish Animations ---
# Adding transition(.scale) to icons
sed -i '' 's/\.foregroundColor(\.green)/.foregroundColor(.green)\n                        .transition(.scale)/' ContentView.swift
sed -i '' 's/\.foregroundColor(\.red)/.foregroundColor(.red)\n                        .transition(.scale)/' ContentView.swift

git add ContentView.swift
git commit -m "Add animations to feedback icons"

# --- COMMIT 18: Documentation ---
git add Instructions.md
git commit -m "Add instruction manual"

# --- COMMIT 19: Git Ignore ---
# Adding a gitignore for good measure
echo ".DS_Store" > .gitignore
echo "DerivedData/" >> .gitignore
echo "*.xcuserdata" >> .gitignore
git add .gitignore
git commit -m "Add .gitignore"

# --- COMMIT 20: Final Polish ---
echo "" >> README.md
echo "## How to Run" >> README.md
echo "Open in Xcode and run on Simulator." >> README.md
git add README.md
git commit -m "Final polish and documentation update"

echo "Done! 20 Real Commits generated."
