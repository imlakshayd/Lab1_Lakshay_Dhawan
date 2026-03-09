import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel = GameViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Header Row (Score & Timer)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Score: \(viewModel.correctCount)")
                            .font(.headline)
                        Text("High Score: \(viewModel.highScore)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("\(viewModel.timeRemaining)s")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.timeRemaining <= 2 ? .red : .primary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Text("Prime Number Game")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                
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
                        .transition(.scale)
                } else if viewModel.feedback == .wrong {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.red)
                        .transition(.scale)
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
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
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
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    .disabled(viewModel.feedback != .none)
                }
                .padding(.bottom, 50)
            }
        }
        .alert(isPresented: $viewModel.showResultDialog) {
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
