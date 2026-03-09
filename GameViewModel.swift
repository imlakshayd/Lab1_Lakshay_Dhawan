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
