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
