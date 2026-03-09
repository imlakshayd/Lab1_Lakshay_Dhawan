import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 1
    
    init() {
        // Init
    }
}
