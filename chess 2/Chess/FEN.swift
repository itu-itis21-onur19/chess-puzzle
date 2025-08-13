//
//  FEN.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation

class FENParser {
    static func parse(_ fen: String) -> Board {
        var board = Board()
        let fields = fen.split(separator: " ")
        guard fields.count >= 1 else { return board }

        let rows = fields[0].split(separator: "/")
        for (rankIndex, row) in rows.enumerated() {
            var file = 0
            for char in row {
                if let digit = char.wholeNumberValue {
                    file += digit
                } else {
                    let color: PieceColor = char.isUppercase ? .white : .black
                    let roleChar = char.lowercased()
                    guard let role = parseRole(roleChar) else { continue }

                    let square = Square(file: file, rank: 7 - rankIndex)
                    if let square = square {
                        board[square] = Piece(role: role, color: color)
                    }
                    file += 1
                }
            }
        }

        return board
    }

    private static func parseRole(_ char: String) -> Role? {
        switch char {
        case "p": return .pawn
        case "r": return .rook
        case "n": return .knight
        case "b": return .bishop
        case "q": return .queen
        case "k": return .king
        default: return nil
        }
    }
}
