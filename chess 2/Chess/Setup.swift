//
//  Setup.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation

struct Setup {
    var board: Board
    var turn: PieceColor
    var castling: String
    var enPassant: Square?
    var halfmoveClock: Int
    var fullmoveNumber: Int

    init(fen: String) {
        let fields = fen.split(separator: " ")
        self.board = FENParser.parse(fen)

        if fields.count >= 2 {
            self.turn = fields[1] == "w" ? .white : .black
        } else {
            self.turn = .white
        }

        self.castling = fields.count >= 3 ? String(fields[2]) : "-"
        if fields.count >= 4 {
            self.enPassant = Square(notation: String(fields[3]))
        } else {
            self.enPassant = nil
        }

        self.halfmoveClock = fields.count >= 5 ? Int(fields[4]) ?? 0 : 0
        self.fullmoveNumber = fields.count >= 6 ? Int(fields[5]) ?? 1 : 1
    }

    static func standard() -> Setup {
        return Setup(fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
    }
}
