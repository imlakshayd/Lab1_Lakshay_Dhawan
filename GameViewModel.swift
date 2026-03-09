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
