//
//  ChessGame.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation

class ChessGame {
    var board: Board
    var currentPlayer: PieceColor = .white

    init(fen: String? = nil) {
        if let fen = fen {
            self.board = FENParser.parse(fen)
            let fields = fen.split(separator: " ")
            if fields.count > 1 {
                self.currentPlayer = fields[1] == "b" ? .black : .white
            }
        } else {
            let setup = Setup.standard()
            self.board = setup.board
            self.currentPlayer = setup.turn
        }
    }

    func legalMoves(from square: Square) -> [Square] {
        guard let piece = board[square], piece.color == currentPlayer else {
            return []
        }

        var moves: [Square] = []

        switch piece.role {
        case .pawn:
            let dir = piece.color == .white ? 1 : -1
            let startRank = piece.color == .white ? 1 : 6
            let nextRank = square.rank + dir

            // One square forward
            if (0..<8).contains(nextRank) {
                let forward = Square(file: square.file, rank: nextRank)
                if let forward = forward, board[forward] == nil {
                    moves.append(forward)

                    // Two squares forward from starting rank
                    if square.rank == startRank {
                        let twoForwardRank = square.rank + 2 * dir
                        let twoForward = Square(file: square.file, rank: twoForwardRank)
                        if let twoForward = twoForward, board[twoForward] == nil {
                            moves.append(twoForward)
                        }
                    }
                }
            }

            // Add diagonal capture
            moves += Attack.pawnAttacks(from: square, color: piece.color).filter {
                return board[$0]?.color == piece.color.opposite
            }

        case .knight:
            moves += Attack.knightAttacks(from: square).filter {
                board[$0]?.color != piece.color
            }

        case .bishop:
            moves += Attack.bishopAttacks(board: board, from: square)

        case .rook:
            moves += Attack.rookAttacks(board: board, from: square)

        case .queen:
            moves += Attack.queenAttacks(board: board, from: square)

        case .king:
            moves += Attack.kingAttacks(from: square).filter {
                board[$0]?.color != piece.color
            }
        }

        return moves
    }

    func makeMove(from: Square, to: Square) -> String? {
        guard legalMoves(from: from).contains(to),
              let movingPiece = board[from] else {
            return nil
        }

        board[to] = movingPiece
        board[from] = nil
        currentPlayer = (currentPlayer == .white) ? .black : .white
        return from.notation + to.notation
        // return pgnNotation(for: movingPiece.role) + to.notation
    }
    
    func makeMove2(pgn: String) -> (from: Square, to: Square)? {
        guard pgn.count == 4 else {
            print("Invalid PGN format")
            return nil
        }

        let fromPGN = String(pgn.prefix(2))  // e.g. "g2"
        let toPGN = String(pgn.suffix(2))   // e.g. "f3"

        guard let from = Square(notation: fromPGN), let to = Square(notation: toPGN) else {
            print("Invalid square notation")
            return nil
        }
        
        print("Making move: \(from) \(to)")
        makeMove(from: from, to: to)
        return (from, to)
    }
    
    func makeMove(pgn: String) -> (from: Square, to: Square)?  {
        // Handle only simple PGN like "e4", "Nf3", "Qh5", "Rxa7", etc.
        let fileLetters = "abcdefgh"
        let rankNumbers = "12345678"

        var role: Role = .pawn
        var destinationStr = pgn
        var capture = false

        // Detect if it starts with piece initial
        if let first = pgn.first, "NBRQK".contains(first) {
            switch first {
            case "N": role = .knight
            case "B": role = .bishop
            case "R": role = .rook
            case "Q": role = .queen
            case "K": role = .king
            default: break
            }
            destinationStr = String(pgn.dropFirst())
        }

        // Detect capture notation
        if destinationStr.contains("x") {
            capture = true
            destinationStr = destinationStr.replacingOccurrences(of: "x", with: "")
        }

        // Extract destination square
        guard destinationStr.count == 2,
              let fileChar = destinationStr.first,
              let rankChar = destinationStr.last,
              let file = fileLetters.firstIndex(of: fileChar)?.utf16Offset(in: fileLetters),
              let rank = Int(String(rankChar)).map({ $0 - 1 }),
              let toSquare = Square(file: file, rank: rank) else {
            return nil
        }

        // Find matching piece of correct role and color that can move there
        let candidates = board.allPieces().filter { $0.1.role == role && $0.1.color == currentPlayer }

        for (fromSquare, _) in candidates {
            let moves = legalMoves(from: fromSquare)
            if moves.contains(toSquare) {
                _ = makeMove(from: fromSquare, to: toSquare)
                return (fromSquare, toSquare)
            }
        }
        return nil
    }

    func isCheckmate() -> Bool {
        if !isKingInCheck(for: currentPlayer) {
            return false
        }

        for (square, piece) in board.allPieces() where piece.color == currentPlayer {
            let moves = legalMoves(from: square)
            for move in moves {
                var copy = self
                _ = copy.makeMove(from: square, to: move)
                if !copy.isKingInCheck(for: currentPlayer) {
                    return false
                }
            }
        }

        return true
    }
}

private extension ChessGame {
    func isKingInCheck(for color: PieceColor) -> Bool {
        guard let kingSquare = board.allPieces().first(where: { $0.1.role == .king && $0.1.color == color })?.0 else {
            return false
        }
        let opponent = color == .white ? PieceColor.black : PieceColor.white
        return board.allPieces().contains(where: { square, piece in
            piece.color == opponent &&
            legalMoves(from: square).contains(kingSquare)
        })
    }

    func pgnNotation(for role: Role) -> String {
        switch role {
        case .pawn: return ""
        case .knight: return "N"
        case .bishop: return "B"
        case .rook: return "R"
        case .queen: return "Q"
        case .king: return "K"
        }
    }
}
