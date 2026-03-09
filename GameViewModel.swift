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
