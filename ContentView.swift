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
