import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    // MARK: - Properties
    @Published var currentNumber: Int = 1 // Default start value
    @Published var correctCount: Int = 0 {
        didSet {
            // Update high score if current score surpasses it
            if correctCount > highScore {
                highScore = correctCount
            }
        }
    }
    @Published var wrongCount: Int = 0
    @Published var attempts: Int = 0
    @Published var showResultDialog: Bool = false
    @Published var feedback: FeedbackType = .none
    
    // New properties for timer and high score
    @Published var timeRemaining: Int = 5
    @AppStorage("HighScore") var highScore: Int = 0
    
    enum FeedbackType {
        case none
        case correct
        case wrong
    }
    
    private var timerCurrentSubscription: AnyCancellable? // Timer for the 5-second countdown
    
    init() {
        startNewRound()
    }
    
    /// Starts a new round of the game 
    func startNewRound() {
        let maxAttempts = 10
        if attempts >= maxAttempts {
            showResultDialog = true
            timerCurrentSubscription?.cancel()
            return
        }
        
        generateRandomNumber()
        feedback = .none
        timeRemaining = 5 // reset timer
        startTimer()
    }
    
    // MARK: - Game Logic
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
    }
    
    func isNumberPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var divisor = 2
        while divisor * divisor <= number {
            if number % divisor == 0 {
                return false
            }
            divisor += 1
        }
        return true
    }
    
    func checkAnswer(isPrimeSelected: Bool) {
        timerCurrentSubscription?.cancel()
        let isActuallyPrime = isNumberPrime(currentNumber)
        if isPrimeSelected == isActuallyPrime {
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
        timerCurrentSubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.handleTimeout()
                }
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
    
    // MARK: - Reset State
    
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attempts = 0
        showResultDialog = false
        startNewRound()
    }
}
