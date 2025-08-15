//
//  PuzzleView.swift
//  chess 2
//
//  Created by Çiğdem Onur on 26.05.2025.
//

import SwiftUI

struct PuzzleView: View {
    let puzzle: Puzzle
    let level: Int
    let dismiss: DismissAction
    let next: () -> Void
    
    @State var phase: PuzzleState = .start
    
    init(puzzle: Puzzle, level: Int, dismiss: DismissAction, next: @escaping () -> Void) {
        self.puzzle = puzzle
        self.level = level
        self.dismiss = dismiss
        self.next = next
        
        let chessVM = ChessViewModel(fen: nil)
        
        self._viewModel = StateObject(wrappedValue: chessVM)
    }
    
    private func reset() {
        phase = .start
        
        viewModel.set(fen: puzzle.FEN)
    }
    
    private func showSolution() {
        viewModel.set(fen: puzzle.FEN)
        
        print(puzzle.move.components(separatedBy: " ").first)

        if let move = puzzle.move.components(separatedBy: " ").first, let (from, to) = viewModel.game.makeMove2(pgn: move) {
            viewModel.from = from
            viewModel.to = to
        }
        
        phase = .solution
    }
    
    @StateObject var viewModel: ChessViewModel = ChessViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Puzzle \(level)")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                Text(puzzle.theme.text)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(12)
                    .background(puzzle.theme.color)
                    .clipShape(.capsule)
                ChessView()
                    .clipShape(.rect(cornerRadius: 16))
                    .environmentObject(viewModel)
                    .padding()
                    .disabled(phase != .start)
                Spacer()
                switch phase {
                case .start:
                    result("\(viewModel.game.currentPlayer.text) moves", colors: [.blue, .purple])
                case .wrong:
                    VStack {
                        result("wrong!", colors: [.red, .purple])
                        AppButton(text: "try again", colors: [.orange], short: false, action: reset)
                        AppButton(text: "show solution", colors: [.blue], short: false, action: showSolution)
                    }
                case .solution:
                    result("wrong!", colors: [.red, .purple])
                    AppButton(text: level == 5 ? "main menu" : "next", colors: [.green], short: false, action: next)
                case .correct:
                    VStack {
                        result("correct!", colors: [.green, .mint])
                        AppButton(text: level == 5 ? "main menu" : "next", colors: [.green], short: false, action: next)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                }
            }
        }
        .onAppear {
            viewModel.set(fen: puzzle.FEN)
        }
        .onChange(of: viewModel.lastMove, { _, move in
            if let move {
                if puzzle.move.components(separatedBy: " ").first == move {
                    phase = .correct
                    print("correct move")
                }
                else {
                    phase = .wrong
                    print("wrong move")
                }
            }
        })
        .background(
            LinearGradient(colors: [
                .purple.opacity(0.75), .pink.opacity(0.75)
            ], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
    }
    
    func result(_ text: String, colors: [Color]) -> some View {
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing), lineWidth: 4)
            )
            .background(.white.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
    }
}
