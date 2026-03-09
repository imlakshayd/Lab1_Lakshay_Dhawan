import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    // MARK: - Properties
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
