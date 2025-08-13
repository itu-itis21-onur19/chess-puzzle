//
//  ChessViewModel.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//


import Foundation

class ChessViewModel: ObservableObject {
    @Published private(set) var game: ChessGame
    @Published var selectedSquare: Square?
    @Published var legalTargets: [Square] = []
    
    @Published var lastMove: String? = nil
    
    @Published var from: Square?
    @Published var to: Square?

    init(fen: String? = nil) {
        self.game = ChessGame(fen: fen)
    }

    func select(square: Square) {
        if selectedSquare == square {
            selectedSquare = nil
            legalTargets = []
        } else if let piece = game.board[square], piece.color == game.currentPlayer {
            selectedSquare = square
            legalTargets = game.legalMoves(from: square)
        } else if let from = selectedSquare, legalTargets.contains(square) {
            let move = game.makeMove(from: from, to: square)
            selectedSquare = nil
            legalTargets = []
            self.lastMove = move
        } else {
            selectedSquare = nil
            legalTargets = []
        }
    }

    func piece(at square: Square) -> Piece? {
        return game.board[square]
    }

    func isSquareHighlighted(_ square: Square) -> Bool {
        return legalTargets.contains(square)
    }
    
    func set(fen: String) {
        self.game = ChessGame(fen: fen)
        self.lastMove = nil
    }
}
